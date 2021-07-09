import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/app_enums.dart';
import 'package:centic_bids/app/core/app_firebase_helper.dart';
import 'package:centic_bids/app/features/auction/data/models/auction_model.dart';
import 'package:centic_bids/app/features/auction/data/models/bid_model.dart';
import 'package:centic_bids/app/features/auction/data/models/place_bid_request_model.dart';
import 'package:centic_bids/app/features/auth/data/models/user_model.dart';
import 'package:centic_bids/app/utils/error_code.dart';
import 'package:centic_bids/app/utils/exception.dart';
import 'package:centic_bids/app/utils/success.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auction_remote_data_source.dart';

class AuctionRemoteDataSourceImpl implements AuctionRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuctionRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Future tryWithException(Function function) async {
    try {
      return await function();
    } on FirebaseAuthException catch (ex) {
      try {
        final FirebaseErrorCodes firebaseCode = FirebaseErrorCodes.values
            .firstWhere((element) => element.toFirebaseString() == ex.code);
        throw ServerException(firebaseCode.getAppErrorCode());
      } on ServerException catch (ex) {
        throw ex;
      } on StateError catch (ex) {
        throw ServerException(ErrorCode.e_1500);
      } catch (ex) {
        throw UnknownException(ErrorCode.e_1000);
      }
    } on FirebaseException catch (ex) {
      throw ServerException(ErrorCode.e_1100);
    } on ServerException catch (ex) {
      throw ex;
    } on UnknownException catch (ex) {
      throw ex;
    } catch (ex) {
      throw UnknownException(ErrorCode.e_1000);
    }
  }

  @override
  Future<List<AuctionModel>> getOngoingAuctionsFirstList(
      {required AuctionListSortType auctionListSortType}) async {
    return await tryWithException(() async {
      // Get auction docs
      final auctionDocs = await firebaseFirestore
          .collection(FirestoreName.auctions_collection)
          .where("endDate", isGreaterThan: DateTime.now())
          .orderBy("endDate",
              descending:
                  auctionListSortType == AuctionListSortType.remainingTimeUp)
          .limit(AppConstants.pagination_limit)
          .get();

      // for (final d in auctionDocs.docs) {
      //   await firebaseFirestore
      //       .collection(FirestoreName.auctions_collection)
      //       .add(d.data());
      // }

      // Check precondition empty
      if (auctionDocs.size == 0) return <AuctionModel>[];

      // Auction list
      return auctionDocs.docs
          .map((auctionDoc) => AuctionModel.fromDocument(auctionDoc))
          .toList();
    });
  }

  @override
  Future<List<AuctionModel>> getOngoingAuctionsNextList(
      {required String startAfterAuctionId,
      required AuctionListSortType auctionListSortType}) async {
    return await tryWithException(() async {
      // Get last doc
      final lastDoc = await firebaseFirestore
          .collection(FirestoreName.auctions_collection)
          .doc(startAfterAuctionId)
          .get();

      // Get auction docs
      final auctionDocs = await firebaseFirestore
          .collection(FirestoreName.auctions_collection)
          .where("endDate", isGreaterThan: DateTime.now())
          .orderBy("endDate",
              descending:
                  auctionListSortType == AuctionListSortType.remainingTimeUp)
          .startAfterDocument(lastDoc)
          .limit(AppConstants.pagination_limit)
          .get();

      // Check precondition empty
      if (auctionDocs.size == 0) return <AuctionModel>[];

      // Auction list
      return auctionDocs.docs
          .map((auctionDoc) => AuctionModel.fromDocument(auctionDoc))
          .toList();
    });
  }

  @override
  Future<Success> placeBid(
      {required PlaceBidRequestModel placeBidRequestModel}) async {
    return await tryWithException(() async {
      // Run transaction
      return await firebaseFirestore.runTransaction((transaction) async {
        // setup
        final latestAuctionDocRef = firebaseFirestore
            .collection(FirestoreName.auctions_collection)
            .doc(placeBidRequestModel.auction.id);

        final latestAuctionDoc = await transaction.get(latestAuctionDocRef);
        final latestAuction = AuctionModel.fromDocument(latestAuctionDoc);

        // Check pre conditions
        final double price = latestAuction.latestBid == 0
            ? latestAuction.basePrice
            : latestAuction.latestBid;
        if (DateTime.now().isAfter(latestAuction.endDate))
          throw ServerException(ErrorCode.e_2010);
        if (latestAuction.latestBid != placeBidRequestModel.auction.latestBid)
          throw ServerException(ErrorCode.e_2020);
        if (placeBidRequestModel.bid <= price)
          throw ServerException(ErrorCode.e_2020);

        // Place new bid
        final newBidDocRef = latestAuctionDocRef
            .collection(FirestoreName.bidList_collection)
            .doc();
        final userDocRef = firebaseFirestore
            .collection(FirestoreName.users_collection)
            .doc(firebaseAuth.currentUser!.uid);

        final newBid = BidModel(
            id: newBidDocRef.id,
            bidUserID: firebaseAuth.currentUser!.uid,
            bid: placeBidRequestModel.bid,
            createdDate: DateTime.now());

        // Add new bid to bid list
        transaction.set(newBidDocRef, newBid.toMap());
        // Update auction
        transaction.update(latestAuctionDocRef, {
          "latestBid": placeBidRequestModel.bid,
          "latestBidUserID": firebaseAuth.currentUser!.uid,
          "bidCount": FieldValue.increment(1),
        });
        // Update user watch list
        transaction.update(userDocRef, {
          "watchList": FieldValue.arrayUnion([latestAuctionDoc.id])
        });

        return RemoteOperationSuccess();
      });
    });
  }

  @override
  Future<AuctionModel> getAuction({required String auctionId}) async {
    return await tryWithException(() async {
      // Get auction doc
      final auctionDoc = await firebaseFirestore
          .collection(FirestoreName.auctions_collection)
          .doc(auctionId)
          .get();

      // Create auction
      return AuctionModel.fromDocument(auctionDoc);
    });
  }

  @override
  Future<List<AuctionModel>> getMyBids() async {
    return await tryWithException(() async {
      // Get user doc
      final userDoc = await firebaseFirestore
          .collection(FirestoreName.users_collection)
          .doc(firebaseAuth.currentUser!.uid)
          .get();

      // Get watch list
      final watchList = UserModel.fromDocument(userDoc).watchList;

      // Check precondition empty
      if (watchList.length == 0) return <AuctionModel>[];

      // Get auction docs
      final getAuctionFutureList = watchList
          .map((auctionId) => getAuction(auctionId: auctionId))
          .toList();

      // Auction list
      final auctionList = await Future.wait(getAuctionFutureList);
      auctionList.sort((a, b) => a.endDate.compareTo(b.endDate));

      return auctionList;
    });
  }
}

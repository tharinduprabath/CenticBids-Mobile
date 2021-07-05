import 'package:centic_bids/app/core/app_enums.dart';
import 'package:centic_bids/app/core/app_firebase_helper.dart';
import 'package:centic_bids/app/features/auctions/data/models/auction_model.dart';
import 'package:centic_bids/app/features/auctions/data/models/bid_model.dart';
import 'package:centic_bids/app/utils/error_code.dart';
import 'package:centic_bids/app/utils/exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

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
  Future<List<AuctionModel>> getOngoingAuctions() async {
    return await tryWithException(() async {
      // Get auction docs
      final QuerySnapshot auctionDocs = await firebaseFirestore
          .collection(FirestoreName.auctions_collection)
          .where("state", isEqualTo: describeEnum(AuctionState.ongoing))
          .get();

      // Check empty
      if (auctionDocs.size == 0) return <AuctionModel>[];

      // Get bid docs and create auction list
      final List<AuctionModel> auctionList = [];

      for (final auctionDoc in auctionDocs.docs) {
        // Get bid docs
        final bidListPath =
            "${FirestoreName.auctions_collection}/${auctionDoc.id}/${FirestoreName.bidList_collection}";
        final QuerySnapshot bidDocs =
            await firebaseFirestore.collection(bidListPath).get();

        // Create bid list
        final List<BidModel> bidList = bidDocs.docs.map((bidDoc) {
          final bidData = (bidDoc.data() as Map<String, dynamic>)
            ..addAll({"id": bidDoc.id});
          final BidModel bid = BidModel.fromMap(bidData);
          return bid;
        }).toList();

        // Create auction
        final auctionData = (auctionDoc.data() as Map<String, dynamic>)
          ..addAll({"id": auctionDoc.id, "bidList": bidList});
        final AuctionModel auction = AuctionModel.fromMap(auctionData);

        // Add auction to auction list
        auctionList.add(auction);
      }

      return auctionList;
    });
  }
}

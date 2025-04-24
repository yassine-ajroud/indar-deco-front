import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:indar_deco/core/errors/failures/failures.dart';
import 'package:indar_deco/data/data_sources/local_data_source/authentication_local_data_source.dart';
import 'package:indar_deco/data/data_sources/remote_data_source/authentication_remote_data_source.dart';
import 'package:indar_deco/domain/entities/token.dart';
import 'package:indar_deco/domain/entities/user.dart';


import '../../core/errors/exceptions/exceptions.dart';
import '../../domain/repositories/authentication_repository.dart';

import '../models/token_model.dart';


class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource authRemoteDataSource;
  final AuthenticationLocalDataSource authLocalDataSource;
  const AuthenticationRepositoryImpl(
      {required this.authRemoteDataSource, required this.authLocalDataSource});

  @override
  Future<Either<Failure, Token>> autologin()async {
        try {
     final tk= await authRemoteDataSource.autoLogin();
     return right(tk);
    } on NotAuthorizedException {
      return left(NotAuthorizedFailure());
    } 
  }

  @override
  Future<Either<Failure, String>> createAccount({required String? address,required String? email,required firstName,required lastName,required password,required String? phone,required String image,required String? oauth,required String? birthDate, required String? gender, required String? recoveryEmail}) async{
     try {
      final res = await authRemoteDataSource.createAccount(firstName: firstName,
          lastName: lastName,
          address: address,
          email: email,
          birthDate: birthDate,
          gender: gender,
          phone: phone,
          image:image,
          oauth:oauth,
          password: password);
      return Right(res);
    } on RegistrationException catch(e){
      return Left(RegistrationFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String,dynamic>>> facebookLogin() async{
        try {
      final tm = await authRemoteDataSource.facebookLogin();
    // await authLocalDataSource.saveUserInformations(tm);

      return right(tm);
    } on LoginException catch (e) {
      return left(LoginFailure(e.message));
    } on LocalStorageException {
      return left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> forgetPassword({required String email,required String destination})async {
           try {
      await authRemoteDataSource.forgetPassword(email:email,destination: destination);
      return const Right(unit);
    }on DataNotFoundException catch(e){
    return Left(DataNotFoundFailure(e.message));} 
    on ServerException catch(e){
      return Left(ServerFailure(message:e.message));
  }}

  @override
  Future<Either<Failure, User>> getUser(String id) async{
     try {
      final model = await authRemoteDataSource.getcurrentUser(id);
      return Right(User(
        id: id,
          ban: model.ban,
          cart: model.cart,
          wishlist: model.wishlist,
          recoveryEmail: model.recoveryEmail,
          oAuth: model.oAuth,
          image: model.image,
          address: model.address,
          birthDate: model.birthDate,
          gender: model.gender,
          firstName: model.firstName,
          lastName: model.lastName,
          email: model.email,
          phone: model.phone,
          password: model.password));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String,dynamic>>> googleLogin() async{
            try {
      final tm = await authRemoteDataSource.googleLogin();
      return right(tm);
    } on LoginException catch (e) {
      return left(LoginFailure(e.message));
    } on LocalStorageException {
      return left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, Token>> login({required String email, required String password}) async{
    try {
      TokenModel tm = await authRemoteDataSource.login(email, password);
      await authLocalDataSource.saveUserInformations(tm);
      Token t = Token(
          token: tm.token,
          refreshToken: tm.refreshToken,
          expiryDate: tm.expiryDate,
          userId: tm.userId);
      return right(t);
    } on LoginException catch (e) {
      return left(LoginFailure(e.message));
    } on LocalStorageException {
      return left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async{
      try {
      await authLocalDataSource.logout();
      return right(unit);
    } catch (e) {
      return left(LocalStorageFailure());
    }
  }


  @override
  Future<Either<Failure, Unit>> resetPassword({required String email, required String password}) async{
        try {
      await authRemoteDataSource.resetPassword(email,password);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword({required String userId, required String oldPassword, required String newPassword,required String recoverEmail}) async{
         try {
      await authRemoteDataSource.updatePassword(userId,oldPassword,newPassword,recoverEmail);
      return const Right(unit);
    }on DataNotFoundException catch (e){
      return Left(DataNotFoundFailure(e.message));
    } 
    on ServerException catch(e){
      return Left(ServerFailure(message:e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfil({required address,required email,required firstName,required lastName,required phone, required id,required birthDate,required gender})async {
        try {
      await authRemoteDataSource.updateProfil(address: address,email: email,firstName: firstName,lastName: lastName,phone: phone,id: id,birthdate: birthDate,gender: gender);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyOTP({required String email, required int otp})async {
         try {
      await authRemoteDataSource.verifyOTP(email,otp);
      return const Right(unit);
    } on BadOTPException catch (e){
      return Left(BadOTPFailure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, Unit>> setUserImage(String userId,String url) async{
          try {
      await authRemoteDataSource.setUserImage(userId,url);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUserImage({required String userId, required File file})async {
           try {
      await authRemoteDataSource.updateUserImage(userId,file);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, String?>> getRecoveryEmail({required String email}) async{
             try {
      final res =await authRemoteDataSource.getRecoveryEmail(email);
      return  Right(res);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, Unit>> updateUserCart({required cart, required id}) async{
     try {
      await authRemoteDataSource.updateCart(cart: cart,id: id);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, Unit>> updateUserWishlist({required wishlist, required id})async {
       try {
      await authRemoteDataSource.updateWishlist(wishlist: wishlist,id: id);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  
}

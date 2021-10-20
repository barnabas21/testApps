<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\PostController;
use App\Http\Controllers\EnterpriseController;


/************  USERS  ************/
//Route::get('/users', [UserController::class, 'getAllUsers']);
Route::post('/user/store', [UserController::class, 'storeUser']);
Route::get('/user/get/{user:username}', [UserController::class, 'getUser']);
Route::post('/user/edit', [UserController::class, 'editUser']);
Route::post('/user/delete', [UserController::class, 'deleteUser']);

/************  POSTS  ************/
Route::post('/post/store', [PostController::class, 'storePost']);
Route::get('/post/get/{post:id}', [PostController::class, 'getPost']);
Route::get('/post/getAllPosts/{post:user_id}', [PostController::class, 'getUserPosts']);
Route::post('/post/edit', [PostController::class, 'editPost']);
Route::post('/post/delete', [PostController::class, 'deletePost']);

/************  ENTERPRISES  ************/
Route::post('/enterprise/store', [EnterpriseController::class, 'storeEnterprise']);
Route::get('/enterprise/getAllEnterprises/{enterprise:user_id}', [EnterpriseController::class, 'getUserEnterprises']);
Route::get('/enterprise/get/{enterprise:id}', [EnterpriseController::class, 'getEnterprise']);
Route::post('/enterprise/delete', [EnterpriseController::class, 'deleteEnterprise']);
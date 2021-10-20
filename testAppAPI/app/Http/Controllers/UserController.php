<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use App\Models\User;

class UserController extends Controller
{
    //Get all users
    public function getAllUsers()
    {
        $users = DB::table('users')->get();
        return $posts;
    }

    //Get a user
    public function getUser(User $user, Request $request)
    {
        $userQueried = User::where(['username'=>$user->username, 'password'=>$user->password])->get();
        return $userQueried;
    }

    //Save a user
    public function storeUser(Request $request)
    {
        return User::create(
            [
                'name'=>$request->input('name'),
                'username'=>$request->input('username'), 
                'password'=>$request->input('password'),
                'email'=>$request->input('email'),
                'adress'=>$request->input('adress')
            ]
        );
        //$user->save();
    }

    //Edit a user
    public function editUser(User $user, Request $request)
    {
        
        $user = User::where(['username'=>$request->input('username')])->first();

        $user->name = $request->input('name');

        return $user->save();
    }

    //Delete user
    public function deleteUser(Request $request)
    {
        $user = new User();
        $user = User::where(['username'=>$request->input('username')])->first();

        return $user->forceDelete();
    }
}

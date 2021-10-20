<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

use App\Models\Post;

class PostController extends Controller
{
    //Get all posts
    public function getPost(Post $post, Request $request)
    {
        $postQueried = Post::where(['user_id'=>$post->user_id])->get();
        return $postQueried;
    }

    //Get a user's post
    public function getUserPosts(Post $post, Request $request)
    {
        $postQueried = Post::where(['user_id'=>$post->user_id])->get();
        return $postQueried;
    }

    //Save a post
    public function storePost(Request $request)
    {
        return Post::create(
            [
                'title'=>$request->input('title'),
                'message'=>$request->input('message'),
                'user_id'=>$request->input('user_id')
            ]
        );
    }

    //Edit a post
    public function editPost(Post $post, Request $request)
    {
        
        $post = Post::where(['id'=>$request->input('id')])->first();

        $post->title = $request->input('title');
        $post->message = $request->input('message');

        return $post->save();
    }

    //Delete post
    public function deletePost(Request $request)
    {
        $post = new Post();
        $post = Post::where(['id'=>$request->input('id')])->first();

        return $post->forceDelete();
    }
}

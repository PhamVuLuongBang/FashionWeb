<?php
namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class PostComment extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'post_comments';
    protected $fillable = ['user_id', 'post_id', 'comment', 'replied_comment', 'parent_id', 'status'];

    public function user_info()
    {
        return $this->belongsTo(User::class, 'user_id', '_id');
    }

    public function post()
    {
        return $this->belongsTo(Post::class, 'post_id', '_id');
    }

    public function replies()
    {
        return $this->hasMany(PostComment::class, 'parent_id', '_id')->where('status', 'active');
    }

    public static function getAllComments()
    {
        return self::with('user_info')->paginate(10);
    }

    public static function getAllUserComments()
    {
        return self::where('user_id', auth()->user()->id)->with('user_info')->paginate(10);
    }
}

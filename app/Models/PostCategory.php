<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class PostCategory extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'post_categories';
    protected $fillable = ['title', 'slug', 'status'];

    public function post()
    {
        return $this->hasMany(Post::class, 'post_cat_id', '_id')->where('status', 'active');
    }

    public static function getBlogByCategory($slug)
    {
        return self::with('post')->where('slug', $slug)->first();
    }
}
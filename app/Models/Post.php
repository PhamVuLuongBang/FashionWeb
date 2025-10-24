<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class Post extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'posts';
    protected $fillable = [
        'title', 'tags', 'summary', 'slug', 'description', 'photo', 'quote',
        'post_cat_id', 'post_tag_id', 'added_by', 'status'
    ];

    // Accessor cho field photo
    public function getPhotoAttribute($value)
    {
        if ($value && strpos($value, 'http') === 0) {
            return $value;
        }
        if ($value) {
            return asset($value);
        }
        return asset('backend/img/no-image.png');
    }

    // Accessor cho field tags (chuẩn hóa để tránh lỗi array)
    public function getTagsAttribute($value)
    {
        return is_array($value) ? implode(',', $value) : $value;
    }

    public function cat_info()
    {
        return $this->belongsTo(PostCategory::class, 'post_cat_id', '_id');
    }

    public function tag_info()
    {
        return $this->belongsTo(PostTag::class, 'post_tag_id', '_id');
    }

    public function author_info()
    {
        return $this->belongsTo(User::class, 'added_by', '_id');
    }

    public function comments()
    {
        return $this->hasMany(PostComment::class, 'post_id', '_id')
                    ->whereNull('parent_id')
                    ->where('status', 'active')
                    ->with('user_info')
                    ->orderBy('_id', 'DESC');
    }

    public function allComments()
    {
        return $this->hasMany(PostComment::class, 'post_id', '_id')->where('status', 'active');
    }

    public static function getAllPost()
    {
        return self::with(['cat_info', 'author_info'])->orderBy('_id', 'DESC')->paginate(10);
    }

    public static function getPostBySlug($slug)
    {
        return self::with(['tag_info', 'author_info'])
                   ->where('slug', $slug)
                   ->where('status', 'active')
                   ->first();
    }

    public static function getBlogByTag($slug)
    {
        return self::where('tags', $slug)->paginate(8);
    }

    public static function countActivePost()
    {
        return self::where('status', 'active')->count() ?? 0;
    }
}
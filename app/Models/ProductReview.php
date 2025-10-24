<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class ProductReview extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'product_reviews';
    protected $fillable = ['user_id', 'product_id', 'rate', 'review', 'status'];

    public function user_info()
    {
        return $this->belongsTo(User::class, 'user_id', '_id');
    }

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id', '_id');
    }

    public static function getAllReview()
    {
        return self::with('user_info')->paginate(10);
    }

    public static function getAllUserReview()
    {
        return self::where('user_id', auth()->user()->id)->with('user_info')->paginate(10);
    }
}

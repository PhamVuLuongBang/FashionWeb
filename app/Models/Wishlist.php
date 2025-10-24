<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class Wishlist extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'wishlists';
    protected $fillable = ['user_id', 'product_id', 'cart_id', 'price', 'amount', 'quantity'];

    public function product()
    {
        return $this->belongsTo(Product::class, 'product_id', '_id');
    }

    public function cart()
    {
        return $this->belongsTo(Cart::class, 'cart_id', '_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', '_id');
    }
}

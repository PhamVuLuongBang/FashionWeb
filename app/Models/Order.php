<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class Order extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'orders';
    protected $fillable = [
        'user_id', 'order_number', 'sub_total', 'quantity', 'delivery_charge', 'status',
        'total_amount', 'first_name', 'last_name', 'country', 'post_code', 'address1',
        'address2', 'phone', 'email', 'payment_method', 'payment_status', 'shipping_id', 'coupon'
    ];

    public function cart_info()
    {
        return $this->hasMany(Cart::class, 'order_id', '_id');
    }

    public function cart()
    {
        return $this->hasMany(Cart::class, 'order_id', '_id');
    }

    public function shipping()
    {
        return $this->belongsTo(Shipping::class, 'shipping_id', '_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', '_id');
    }

    public static function getAllOrder($id)
    {
        return self::with('cart_info')->find($id);
    }

    public static function countActiveOrder()
    {
        return self::count() ?? 0;
    }
}
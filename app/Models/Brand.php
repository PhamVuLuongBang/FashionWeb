<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class Brand extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'brands';
    protected $fillable = ['title', 'slug', 'status'];

    public function products()
    {
        return $this->hasMany(Product::class, 'brand_id', '_id')->where('status', 'active');
    }

    public static function getProductByBrand($slug)
    {
        return self::with('products')->where('slug', $slug)->first();
    }
}
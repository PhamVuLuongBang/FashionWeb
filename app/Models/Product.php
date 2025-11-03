<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class Product extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'products';

    protected $fillable = [
        'title', 'slug', 'summary', 'description', 'cat_id', 'child_cat_id',
        'price', 'brand_id', 'discount', 'status', 'photo', 'size', 'stock',
        'is_featured', 'condition'
    ];

    protected $casts = [
        'is_featured' => 'boolean',
        'price'       => 'float',
        'discount'    => 'float',
        'stock'       => 'integer',
        // 'size'        => 'array', // vì bạn lưu implode(',')
        'created_at'  => 'datetime',
        'updated_at'  => 'datetime',
    ];

    // Accessor cho field photo
    public function getPhotoAttribute($value)
    {
        if ($value && (str_starts_with($value, 'http://') || str_starts_with($value, 'https://'))) {
            return $value;
        }
        return $value ? asset($value) : asset('backend/img/no-image.png');
    }

    public function cat_info()
    {
        return $this->belongsTo(Category::class, 'cat_id', '_id');
    }

    public function sub_cat_info()
    {
        return $this->belongsTo(Category::class, 'child_cat_id', '_id');
    }

    public function brand()
    {
        return $this->belongsTo(Brand::class, 'brand_id', '_id');
    }

    public function rel_prods()
    {
        return $this->hasMany(Product::class, 'cat_id', 'cat_id')
                    ->where('status', 'active')
                    ->orderBy('_id', 'DESC')
                    ->limit(8);
    }

    public function getReview()
    {
        return $this->hasMany(ProductReview::class, 'product_id', '_id')
                    ->with('user_info')
                    ->where('status', 'active')
                    ->orderBy('_id', 'DESC');
    }

    public function carts()
    {
        return $this->hasMany(Cart::class, 'product_id', '_id')->whereNotNull('order_id');
    }

    public function wishlists()
    {
        return $this->hasMany(Wishlist::class, 'product_id', '_id')->whereNotNull('cart_id');
    }

    public static function getAllProduct()
    {
        return self::with(['cat_info', 'sub_cat_info', 'brand'])
                   ->orderBy('_id', 'DESC')
                   ->paginate(10);
    }

    public static function getProductBySlug($slug)
    {
        return self::with(['cat_info', 'rel_prods', 'getReview'])
                   ->where('slug', $slug)
                   ->first();
    }

    public static function countActiveProduct()
    {
        return self::where('status', 'active')->count() ?? 0;
    }
}
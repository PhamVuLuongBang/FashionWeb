<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class Category extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'categories';
    protected $fillable = ['title', 'slug', 'summary', 'photo', 'status', 'is_parent', 'parent_id', 'added_by'];

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

    public function parent_info()
    {
        return $this->belongsTo(Category::class, 'parent_id', '_id');
    }

    public function child_cat()
    {
        return $this->hasMany(Category::class, 'parent_id', '_id')->where('status', 'active');
    }

    public function products()
    {
        return $this->hasMany(Product::class, 'cat_id', '_id')->where('status', 'active');
    }

    public function sub_products()
    {
        return $this->hasMany(Product::class, 'child_cat_id', '_id')->where('status', 'active');
    }

    public static function getAllCategory()
    {
        return self::with('parent_info')->orderBy('_id', 'DESC')->paginate(10);
    }

    public static function shiftChild($cat_id)
    {
        return self::whereIn('_id', $cat_id)->update(['is_parent' => true]);
    }

    public static function getChildByParentID($id)
    {
        return self::where('parent_id', $id)->orderBy('_id', 'ASC')->pluck('title', '_id');
    }

    public static function getAllParentWithChild()
    {
        return self::with('child_cat')->where('is_parent', true)->where('status', 'active')->orderBy('title', 'ASC')->get();
    }

    public static function getProductByCat($slug)
    {
        return self::with('products')->where('slug', $slug)->first();
    }

    public static function getProductBySubCat($slug)
    {
        return self::with('sub_products')->where('slug', $slug)->first();
    }

    public static function countActiveCategory()
    {
        return self::where('status', 'active')->count() ?? 0;
    }
}
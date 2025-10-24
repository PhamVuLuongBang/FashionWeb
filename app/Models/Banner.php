<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class Banner extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'banners';
    protected $fillable = ['title', 'slug', 'description', 'photo', 'status'];

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
}
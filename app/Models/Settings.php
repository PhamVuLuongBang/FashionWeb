<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class Settings extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'settings';
    protected $fillable = [
        'short_des', 'description', 'photo', 'address', 'phone', 'email', 'logo'
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

    // Accessor cho field logo
    public function getLogoAttribute($value)
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

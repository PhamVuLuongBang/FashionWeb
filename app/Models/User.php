<?php

namespace App\Models;

use MongoDB\Laravel\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use App\Models\Notification;

class User extends Authenticatable
{
    use Notifiable;

    protected $connection = 'mongodb';
    protected $collection = 'users';
    protected $fillable = [
        'name', 'email', 'email_verified_at', 'password', 'photo',
        'role', 'provider', 'provider_id', 'status', 'remember_token'
    ];

    protected $hidden = [
        'password', 'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
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
}
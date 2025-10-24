<?php

namespace App;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use Notifiable;

    protected $fillable = [
        'name', 'email', 'password','role','photo','status','provider','provider_id',
    ];

    protected $hidden = [
        'password', 'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function orders(){
        return $this->hasMany('App\Models\Order');
    }

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

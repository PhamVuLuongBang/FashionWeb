<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class Notification extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'notifications';
    protected $fillable = ['data', 'type', 'notifiable_type', 'notifiable_id', 'read_at'];

    public function user()
    {
        return $this->belongsTo(User::class, 'notifiable_id', '_id');
    }
}
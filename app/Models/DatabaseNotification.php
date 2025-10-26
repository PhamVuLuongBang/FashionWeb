<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;
use Illuminate\Contracts\Support\Arrayable;
use Illuminate\Contracts\Queue\QueueableEntity;
use Illuminate\Queue\SerializesModels;

class DatabaseNotification extends Model implements Arrayable, QueueableEntity
{
    use SerializesModels;

    protected $connection = 'mongodb';
    protected $collection = 'notifications';

    protected $casts = [
        'data' => 'array',
        'read_at' => 'datetime',
    ];

    // Override nếu cần
    public function notifiable()
    {
        return $this->morphTo();
    }
}
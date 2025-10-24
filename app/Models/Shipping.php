<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class Shipping extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'shippings';
    protected $fillable = ['type', 'price', 'status'];
}
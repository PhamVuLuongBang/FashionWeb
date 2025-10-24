<?php

namespace App\Models;

use MongoDB\Laravel\Eloquent\Model;

class PostTag extends Model
{
    protected $connection = 'mongodb';
    protected $collection = 'post_tags';
    protected $fillable = ['title', 'slug', 'status'];
}

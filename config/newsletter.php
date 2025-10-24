<?php

return [

    /*
     * Driver để kết nối với Mailchimp API.
     * Có thể để "log" hoặc "null" khi test local để không gọi API thật.
     */
    'driver' => Spatie\Newsletter\Drivers\MailchimpDriver::class,

    /*
     * API key của Mailchimp (lấy từ .env).
     */
    'driver_arguments' => [
        'apiKey' => env('MAILCHIMP_APIKEY'),
    ],

    /*
     * Tên list mặc định.
     */
    'defaultListName' => 'subscribers',

    /*
     * Khai báo các list mà bạn dùng.
     */
    'lists' => [

        'subscribers' => [
            'id' => env('MAILCHIMP_LIST_ID'),
        ],

    ],

    /*
     * Bật SSL (nên để true).
     */
    'ssl' => true,

];

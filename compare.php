<?php
require 'vendor/autoload.php';

use MongoDB\Client;

// Kết nối MySQL
$pdo = new PDO("mysql:host=localhost;dbname=shop", "root", "", [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
]);

// Kết nối MongoDB
$mongoClient = new Client("mongodb://localhost:27017");
$mongo = $mongoClient->shop;

$tables = [
    'banners', 'brands', 'categories', 'coupons', 'messages', 'notifications', 'orders',
    'posts', 'post_categories', 'post_comments', 'post_tags', 'products', 'product_reviews',
    'settings', 'shippings', 'users', 'wishlists', 'carts'
];

foreach ($tables as $table) {
    // Đếm số lượng
    $mysqlCount = $pdo->query("SELECT COUNT(*) FROM `$table`")->fetchColumn();
    $mongoCount = $mongo->$table->countDocuments();
    echo "$table: MySQL $mysqlCount vs MongoDB $mongoCount\n";

    // Kiểm tra mẫu dữ liệu (lấy 1 row)
    if ($mysqlCount > 0) {
        $mysqlSample = $pdo->query("SELECT * FROM `$table` LIMIT 1")->fetch(PDO::FETCH_ASSOC);
        $mongoSample = $mongo->$table->findOne();
        
        echo "\nSample for $table:\n";
        echo "MySQL: " . print_r($mysqlSample, true) . "\n";
        echo "MongoDB: " . print_r($mongoSample, true) . "\n";

        // Kiểm tra relationships (cho bảng có foreign keys)
        if (in_array($table, ['carts', 'orders', 'wishlists', 'categories', 'products', 'product_reviews', 'posts', 'post_comments'])) {
            if (isset($mysqlSample['product_id']) && isset($mongoSample['product_id'])) {
                echo "Checking product_id: MySQL={$mysqlSample['product_id']} vs MongoDB=" . ($mongoSample['product_id'] ? $mongoSample['product_id'] : 'null') . "\n";
            }
            if (isset($mysqlSample['user_id']) && isset($mongoSample['user_id'])) {
                echo "Checking user_id: MySQL={$mysqlSample['user_id']} vs MongoDB=" . ($mongoSample['user_id'] ? $mongoSample['user_id'] : 'null') . "\n";
            }
            if (isset($mysqlSample['parent_id']) && isset($mongoSample['parent_id'])) {
                echo "Checking parent_id: MySQL={$mysqlSample['parent_id']} vs MongoDB=" . ($mongoSample['parent_id'] ? $mongoSample['parent_id'] : 'null') . "\n";
            }
        }
    }
}
?>
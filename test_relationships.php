<?php
require 'vendor/autoload.php';
use MongoDB\Client;

$client = new Client("mongodb://localhost:27017");
$db = $client->shop;

// Test cart -> product relationship
$cart = $db->carts->findOne();
echo "Cart found: " . ($cart ? "Yes" : "No") . "\n";
if ($cart && isset($cart->product_id)) {
    $product = $db->products->findOne(['_id' => $cart->product_id]);
    echo "Product found for cart: " . ($product ? "Yes (ID: " . $cart->product_id . ")" : "No") . "\n";
    if ($product) {
        echo "Product title: " . $product->title . "\n";
    }
}

// Test cart -> user relationship
if ($cart && isset($cart->user_id)) {
    $user = $db->users->findOne(['_id' => $cart->user_id]);
    echo "User found for cart: " . ($user ? "Yes (ID: " . $cart->user_id . ", Name: " . $user->name . ")" : "No") . "\n";
}

// Test order -> user relationship
$order = $db->orders->findOne();
if ($order && isset($order->user_id)) {
    $orderUser = $db->users->findOne(['_id' => $order->user_id]);
    echo "User found for order: " . ($orderUser ? "Yes (Name: " . $orderUser->name . ")" : "No") . "\n";
}
?>
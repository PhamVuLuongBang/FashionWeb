<?php
require 'vendor/autoload.php';

use MongoDB\Client;
use MongoDB\BSON\ObjectId;
use MongoDB\BSON\UTCDateTime;

// Kết nối MySQL
$pdo = new PDO("mysql:host=localhost;dbname=shop", "root", "", [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
]);

// Kết nối MongoDB
$mongoClient = new Client("mongodb://localhost:27017");
$db = $mongoClient->shop;

// Danh sách bảng và ánh xạ cột
$tables = [
    'banners' => [
        'fields' => ['title', 'slug', 'photo', 'description', 'status'],
        'transforms' => [
            'status' => 'string',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'brands' => [
        'fields' => ['title', 'slug', 'status'],
        'transforms' => [
            'status' => 'string',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'categories' => [
        'fields' => ['title', 'slug', 'summary', 'photo', 'is_parent', 'parent_id', 'added_by', 'status'],
        'transforms' => [
            'is_parent' => 'bool',
            'parent_id' => 'objectid',
            'added_by' => 'objectid',
            'status' => 'string',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'coupons' => [
        'fields' => ['code', 'type', 'value', 'status'],
        'transforms' => [
            'type' => 'string',
            'value' => 'double',
            'status' => 'string',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'messages' => [
        'fields' => ['name', 'subject', 'email', 'photo', 'phone', 'message', 'read_at'],
        'transforms' => [
            'read_at' => 'datetime',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'notifications' => [
        'fields' => ['id', 'type', 'notifiable_type', 'notifiable_id', 'data', 'read_at'],
        'transforms' => [
            'notifiable_id' => 'objectid',
            'read_at' => 'datetime',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'orders' => [
        'fields' => ['order_number', 'user_id', 'sub_total', 'shipping_id', 'coupon', 'total_amount', 'quantity', 'payment_method', 'payment_status', 'status', 'first_name', 'last_name', 'email', 'phone', 'country', 'post_code', 'address1', 'address2'],
        'transforms' => [
            'user_id' => 'objectid',
            'shipping_id' => 'objectid',
            'sub_total' => 'double',
            'coupon' => 'double',
            'total_amount' => 'double',
            'quantity' => 'int',
            'payment_method' => 'string',
            'payment_status' => 'string',
            'status' => 'string',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'posts' => [
        'fields' => ['title', 'slug', 'summary', 'description', 'quote', 'photo', 'tags', 'post_cat_id', 'post_tag_id', 'added_by', 'status'],
        'transforms' => [
            'tags' => 'array',
            'post_cat_id' => 'objectid',
            'post_tag_id' => 'objectid',
            'added_by' => 'objectid',
            'status' => 'string',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'post_categories' => [
        'fields' => ['title', 'slug', 'status'],
        'transforms' => [
            'status' => 'string',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'post_comments' => [
        'fields' => ['user_id', 'post_id', 'comment', 'status', 'replied_comment', 'parent_id'],
        'transforms' => [
            'user_id' => 'objectid',
            'post_id' => 'objectid',
            'status' => 'string',
            'parent_id' => 'objectid',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'post_tags' => [
        'fields' => ['title', 'slug', 'status'],
        'transforms' => [
            'status' => 'string',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'products' => [
        'fields' => ['title', 'slug', 'summary', 'description', 'photo', 'stock', 'size', 'condition', 'status', 'price', 'discount', 'is_featured', 'cat_id', 'child_cat_id', 'brand_id'],
        'transforms' => [
            'stock' => 'int',
            'size' => 'array',
            'condition' => 'string',
            'status' => 'string',
            'price' => 'double',
            'discount' => 'double',
            'is_featured' => 'bool',
            'cat_id' => 'objectid',
            'child_cat_id' => 'objectid',
            'brand_id' => 'objectid',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'product_reviews' => [
        'fields' => ['user_id', 'product_id', 'rate', 'review', 'status'],
        'transforms' => [
            'user_id' => 'objectid',
            'product_id' => 'objectid',
            'rate' => 'int',
            'status' => 'string',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'settings' => [
        'fields' => ['description', 'short_des', 'logo', 'photo', 'address', 'phone', 'email'],
        'transforms' => [
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'shippings' => [
        'fields' => ['type', 'price', 'status'],
        'transforms' => [
            'price' => 'double',
            'status' => 'string',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'users' => [
        'fields' => ['name', 'email', 'email_verified_at', 'password', 'photo', 'role', 'provider', 'provider_id', 'status', 'remember_token'],
        'transforms' => [
            'email_verified_at' => 'datetime',
            'role' => 'string',
            'status' => 'string',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'wishlists' => [
        'fields' => ['product_id', 'cart_id', 'user_id', 'price', 'quantity', 'amount'],
        'transforms' => [
            'product_id' => 'objectid',
            'cart_id' => 'objectid',
            'user_id' => 'objectid',
            'price' => 'double',
            'quantity' => 'int',
            'amount' => 'double',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ],
    'carts' => [
        'fields' => ['product_id', 'order_id', 'user_id', 'price', 'status', 'quantity', 'amount'],
        'transforms' => [
            'product_id' => 'objectid',
            'order_id' => 'objectid',
            'user_id' => 'objectid',
            'price' => 'double',
            'status' => 'string',
            'quantity' => 'int',
            'amount' => 'double',
            'created_at' => 'datetime',
            'updated_at' => 'datetime'
        ]
    ]
];

// Hàm chuyển đổi dữ liệu
function transformValue($value, $type) {
    if ($value === null || $value === '') return null;
    switch ($type) {
        case 'int':
            return (int)$value;
        case 'double':
            return (double)$value;
        case 'bool':
            return (bool)$value;
        case 'array':
            return !empty($value) ? explode(',', $value) : [];
        case 'objectid':
            return null; // Bỏ transform objectid, dùng mapping
        case 'datetime':
            return $value ? new UTCDateTime(strtotime($value) * 1000) : null;
        case 'string':
            return (string)$value;
        default:
            return $value;
    }
}

// Map refField -> refTable
$refMap = [
    'product_id' => 'products',
    'user_id' => 'users',
    'order_id' => 'orders',
    'parent_id' => 'categories',
    'cat_id' => 'categories',
    'child_cat_id' => 'categories',
    'brand_id' => 'brands',
    'shipping_id' => 'shippings',
    'post_cat_id' => 'post_categories',
    'post_tag_id' => 'post_tags',
    'added_by' => 'users',
    'post_id' => 'posts',
    'cart_id' => 'carts',
    'notifiable_id' => 'users'
];

$idMap = []; // [table][old_id] => new ObjectId

// Thứ tự migrate: Bảng gốc trước, reference sau
$orderedTables = [
    'users', 'brands', 'categories', 'post_categories', 'post_tags', 'products', 'posts', 'shippings', 'settings',
    'banners', 'coupons', 'messages', 'notifications', 'orders', 'carts', 'wishlists', 'post_comments', 'product_reviews'
];

foreach ($orderedTables as $table) {
    if (!isset($tables[$table])) {
        echo "Bảng $table không có config, bỏ qua.\n";
        continue;
    }
    $config = $tables[$table];

    echo "Chuyển bảng $table...\n";
    $collection = $db->$table;
    $collection->drop(); // Xóa collection cũ

    $stmt = $pdo->query("SELECT * FROM `$table`");
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        $document = [];
        
        // Bước 1: Tạo document cơ bản với các fields
        foreach ($config['fields'] as $field) {
            if (array_key_exists($field, $row)) {
                $value = $row[$field];
                if (isset($config['transforms'][$field]) && $config['transforms'][$field] !== 'objectid') {
                    $value = transformValue($value, $config['transforms'][$field]);
                }
                $document[$field] = $value;
            }
        }
        
        // Bước 2: Thêm created_at/updated_at
        if (array_key_exists('created_at', $row)) {
            $document['created_at'] = transformValue($row['created_at'], 'datetime');
        }
        if (array_key_exists('updated_at', $row)) {
            $document['updated_at'] = transformValue($row['updated_at'], 'datetime');
        }

        // Bước 3: Tạo _id mới và lưu vào $idMap TRƯỚC khi xử lý references
        $newId = new ObjectId();
        $document['_id'] = $newId;
        if (array_key_exists('id', $row) && $row['id'] !== null) {
            $idMap[$table][$row['id']] = $newId;
            echo "Created $table ID mapping: {$row['id']} -> {$newId}\n";
        }

        // Bước 4: Xử lý references SAU khi $idMap đã được tạo
        foreach ($refMap as $refField => $refTable) {
            if (array_key_exists($refField, $document)) {
                $oldId = $document[$refField];
                // Chỉ map nếu $oldId không rỗng và không null
                if ($oldId !== null && $oldId !== '') {
                    if (isset($idMap[$refTable][$oldId])) {
                        $document[$refField] = $idMap[$refTable][$oldId];
                        echo "Mapped $table.$refField = $oldId to $refTable: " . $idMap[$refTable][$oldId] . "\n";
                    } else {
                        echo "Warning: No mapping for $table.$refField = $oldId in $refTable\n";
                        $document[$refField] = null;
                    }
                } else {
                    echo "Skipping $table.$refField: value is null or empty\n";
                    $document[$refField] = null;
                }
            }
        }

        // Bước 5: Insert document
        try {
            $collection->insertOne($document);
            echo "Inserted document into $table: _id = {$newId}\n";
        } catch (Exception $e) {
            echo "Lỗi khi chèn vào $table: " . $e->getMessage() . "\n";
        }
    }
    echo "Chuyển bảng $table hoàn tất!\n";
}

// Debug cuối cùng để kiểm tra $idMap
echo "\n=== ID MAP DEBUG ===\n";
foreach ($idMap as $table => $mappings) {
    echo "$table: " . count($mappings) . " mappings\n";
}
if (isset($idMap['users'][3])) {
    echo "User ID 3 mapped to: " . $idMap['users'][3] . "\n";
}
if (isset($idMap['products'][8])) {
    echo "Product ID 8 mapped to: " . $idMap['products'][8] . "\n";
}
if (isset($idMap['categories'][1])) {
    echo "Category ID 1 mapped to: " . $idMap['categories'][1] . "\n";
}

echo "Chuyển đổi toàn bộ database hoàn tất!\n";
?>
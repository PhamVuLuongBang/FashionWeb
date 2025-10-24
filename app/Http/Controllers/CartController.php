<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Wishlist;
use App\Models\Cart;
use Auth;

class CartController extends Controller
{
    protected $product = null;

    public function __construct(Product $product)
    {
        $this->product = $product;
    }

    // =======================
    // Add To Cart
    // =======================
    public function addToCart(Request $request)
    {
        if (empty($request->slug)) {
            return back()->with('error', 'Invalid product');
        }

        $product = Product::where('slug', $request->slug)->first();
        if (!$product) {
            return back()->with('error', 'Invalid product');
        }

        $already_cart = Cart::where('user_id', auth()->id())
            ->whereNull('order_id')
            ->where('product_id', $product->id)
            ->first();

        if ($already_cart) {
            $already_cart->quantity += 1;
            $already_cart->amount = $already_cart->price * $already_cart->quantity;

            if ($product->stock < $already_cart->quantity) {
                return back()->with('error', 'Stock not sufficient!');
            }

            $already_cart->save();
        } else {
            $cart = new Cart;
            $cart->user_id = auth()->id();
            $cart->product_id = $product->id;
            $cart->price = $product->price - ($product->price * $product->discount / 100);
            $cart->quantity = 1;
            $cart->amount = $cart->price * $cart->quantity;

            if ($product->stock < $cart->quantity) {
                return back()->with('error', 'Stock not sufficient!');
            }

            $cart->save();

            // Nếu có trong wishlist thì move qua cart
            Wishlist::where('user_id', auth()->id())
                ->whereNull('cart_id')
                ->update(['cart_id' => $cart->id]);
        }

        return back()->with('success', 'Product successfully added to cart');
    }

    // =======================
    // Add To Cart (with quantity)
    // =======================
    public function singleAddToCart(Request $request)
    {
        $request->validate([
            'slug' => 'required',
            'quant' => 'required|integer|min:1',
        ]);

        $product = Product::where('slug', $request->slug)->first();
        if (!$product) {
            return back()->with('error', 'Invalid product');
        }

        if ($product->stock < $request->quant) {
            return back()->with('error', 'Out of stock, you can add other products.');
        }

        $already_cart = Cart::where('user_id', auth()->id())
            ->whereNull('order_id')
            ->where('product_id', $product->id)
            ->first();

        if ($already_cart) {
            $already_cart->quantity += $request->quant;
            $already_cart->amount = $already_cart->price * $already_cart->quantity;

            if ($product->stock < $already_cart->quantity) {
                return back()->with('error', 'Stock not sufficient!');
            }

            $already_cart->save();
        } else {
            $cart = new Cart;
            $cart->user_id = auth()->id();
            $cart->product_id = $product->id;
            $cart->price = $product->price - ($product->price * $product->discount / 100);
            $cart->quantity = $request->quant;
            $cart->amount = $cart->price * $cart->quantity;

            if ($product->stock < $cart->quantity) {
                return back()->with('error', 'Stock not sufficient!');
            }

            $cart->save();
        }

        return back()->with('success', 'Product successfully added to cart.');
    }

    // =======================
    // Delete Cart Item
    // =======================
    public function cartDelete(Request $request)
    {
        $cart = Cart::find($request->id);
        if ($cart) {
            $cart->delete();
            return back()->with('success', 'Cart successfully removed');
        }
        return back()->with('error', 'Error please try again');
    }

    // =======================
    // Update Cart Quantities
    // =======================
    public function cartUpdate(Request $request)
    {
        if ($request->quant) {
            $error = [];
            $success = '';

            foreach ($request->quant as $k => $quant) {
                $id = $request->qty_id[$k];
                $cart = Cart::find($id);

                if ($quant > 0 && $cart) {
                    if ($cart->product->stock < $quant) {
                        return back()->with('error', 'Out of stock');
                    }

                    $cart->quantity = min($quant, $cart->product->stock);
                    $after_price = $cart->product->price - ($cart->product->price * $cart->product->discount / 100);
                    $cart->price = $after_price;
                    $cart->amount = $after_price * $cart->quantity;
                    $cart->save();

                    $success = 'Cart successfully updated!';
                } else {
                    $error[] = 'Cart Invalid!';
                }
            }

            return back()->with('success', $success)->withErrors($error);
        } else {
            return back()->with('error', 'Cart Invalid!');
        }
    }

    // =======================
    // Checkout Page
    // =======================
    public function checkout(Request $request)
    {
        return view('frontend.pages.checkout');
    }
}

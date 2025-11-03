<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Category;
use App\Models\Brand;
use Illuminate\Support\Str;

class ProductController extends Controller
{
    public function index()
    {
        $products = Product::getAllProduct();
        return view('backend.product.index', compact('products'));
    }

    public function create()
    {
        $brands = Brand::all();
        $categories = Category::where('is_parent', true)->get();
        return view('backend.product.create', compact('categories', 'brands'));
    }

    public function store(Request $request)
    {
        $validatedData = $request->validate([
            'title'       => 'required|string|max:255',
            'summary'     => 'required|string',
            'description' => 'nullable|string',
            'photo'       => 'required|string',
            'size'        => 'nullable|array',
            'stock'       => 'required|integer|min:0',
            'cat_id'      => 'required|exists:mongodb.categories,_id',
            'brand_id'    => 'nullable|exists:mongodb.brands,_id',
            'child_cat_id'=> 'nullable|exists:mongodb.categories,_id',
            'is_featured' => 'sometimes|in:1',
            'status'      => 'required|in:active,inactive',
            'condition'   => 'required|in:default,new,hot',
            'price'       => 'required|numeric|min:0',
            'discount'    => 'nullable|numeric|min:0|max:100',
        ]);

        $slug = generateUniqueSlug($request->title, Product::class);
        $validatedData['slug'] = $slug;
        $validatedData['is_featured'] = $request->boolean('is_featured');

        $validatedData['size'] = $request->has('size') ? $request->input('size') : [];

        $product = Product::create($validatedData);

        return redirect()->route('admin.product.index')->with(
            $product ? 'success' : 'error',
            $product ? 'Product Successfully added' : 'Please try again!!'
        );
    }

    public function edit($id)
    {
        $product = Product::findOrFail($id);
        $brands = Brand::all();
        $categories = Category::where('is_parent', true)->get();

        return view('backend.product.edit', compact('product', 'brands', 'categories'));
    }

    public function update(Request $request, $id)
    {
        $product = Product::findOrFail($id);

        $validatedData = $request->validate([
            'title'       => 'required|string|max:255',
            'summary'     => 'required|string',
            'description' => 'nullable|string',
            'photo'       => 'required|string',
            'size'        => 'nullable|array',
            'stock'       => 'required|integer|min:0',
            'cat_id'      => 'required|exists:mongodb.categories,_id',
            'child_cat_id'=> 'nullable|exists:mongodb.categories,_id',
            'brand_id'    => 'nullable|exists:mongodb.brands,_id',
            'is_featured' => 'sometimes|in:1',
            'status'      => 'required|in:active,inactive',
            'condition'   => 'required|in:default,new,hot',
            'price'       => 'required|numeric|min:0',
            'discount'    => 'nullable|numeric|min:0|max:100',
        ]);

        $validatedData['is_featured'] = $request->boolean('is_featured');
        $validatedData['size'] = $request->has('size') ? $request->input('size') : [];

        $status = $product->update($validatedData);

        return redirect()->route('admin.product.index')->with(
            $status ? 'success' : 'error',
            $status ? 'Product Successfully updated' : 'Please try again!!'
        );
    }

    public function destroy($id)
    {
        $product = Product::findOrFail($id);
        $status = $product->delete();

        return redirect()->route('admin.product.index')->with(
            $status ? 'success' : 'error',
            $status ? 'Product successfully deleted' : 'Error while deleting product'
        );
    }
}
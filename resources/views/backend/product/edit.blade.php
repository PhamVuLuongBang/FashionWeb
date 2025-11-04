@extends('backend.layouts.master')

@section('main-content')
<div class="card">
    <h5 class="card-header">Edit Product</h5>
    <div class="card-body">
        <form method="post" action="{{ route('admin.product.update', $product->_id) }}">
            @csrf 
            @method('PATCH')
            <div class="form-group">
                <label for="inputTitle" class="col-form-label">Title <span class="text-danger">*</span></label>
                <input id="inputTitle" type="text" name="title" placeholder="Enter title" value="{{ old('title', $product->title) }}" class="form-control">
                @error('title')
                <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>

            <div class="form-group">
                <label for="summary" class="col-form-label">Summary <span class="text-danger">*</span></label>
                <textarea class="form-control" id="summary" name="summary">{{ old('summary', $product->summary) }}</textarea>
                @error('summary')
                <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>

            <div class="form-group">
                <label for="description" class="col-form-label">Description</label>
                <textarea class="form-control" id="description" name="description">{{ old('description', $product->description) }}</textarea>
                @error('description')
                <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>

            <div class="form-group">
                <label for="photo" class="col-form-label">Photo <span class="text-danger">*</span></label>
                <div class="input-group col-md-4">
                    <span class="input-group-btn">
                        <a id="lfm" data-input="thumbnail" data-preview="holder" class="btn btn-primary text-white">
                            <i class="fas fa-picture-o"></i> Choose
                        </a>
                    </span>
                    <input id="thumbnail" class="form-control" type="text" name="photo" value="{{ old('photo', $product->photo) }}">
                </div>
                <div id="holder" style="margin-top:15px;max-height:100px;"></div>
                @error('photo')
                <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>

            <div class="form-group">
                <label for="size" class="col-form-label">Size</label>
                <select name="size[]" id="size" class="form-control selectpicker" multiple data-live-search="true">
                    @php
                        $sizes = old('size', is_array($product->size) ? $product->size : explode(',', $product->size ?? ''));
                    @endphp
                    <option value="S" {{ in_array('S', $sizes) ? 'selected' : '' }}>Small</option>
                    <option value="M" {{ in_array('M', $sizes) ? 'selected' : '' }}>Medium</option>
                    <option value="L" {{ in_array('L', $sizes) ? 'selected' : '' }}>Large</option>
                    <option value="XL" {{ in_array('XL', $sizes) ? 'selected' : '' }}>Extra Large</option>
                </select>
                @error('size')
                <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>

            <div class="form-group">
                <label for="condition" class="col-form-label">Condition <span class="text-danger">*</span></label>
                <select name="condition" id="condition" class="form-control">
                    <option value="default" {{ old('condition', $product->condition) == 'default' ? 'selected' : '' }}>Default</option>
                    <option value="new" {{ old('condition', $product->condition) == 'new' ? 'selected' : '' }}>New</option>
                    <option value="hot" {{ old('condition', $product->condition) == 'hot' ? 'selected' : '' }}>Hot</option>
                </select>
                @error('condition')
                <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>

            <div class="form-group">
                <label for="stock" class="col-form-label">Stock <span class="text-danger">*</span></label>
                <input id="stock" type="number" name="stock" min="0" placeholder="Enter stock" value="{{ old('stock', $product->stock) }}" class="form-control">
                @error('stock')
                <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>

            <div class="form-group">
                <label for="price" class="col-form-label">Price <span class="text-danger">*</span></label>
                <input id="price" type="number" name="price" placeholder="Enter price" value="{{ old('price', $product->price) }}" class="form-control">
                @error('price')
                <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>

            <div class="form-group">
                <label for="discount" class="col-form-label">Discount <span class="text-danger">*</span></label>
                <input id="discount" type="number" name="discount" min="0" max="100" placeholder="Enter discount" value="{{ old('discount', $product->discount) }}" class="form-control">
                @error('discount')
                <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>

            <div class="form-group">
                <label for="is_featured">Is Featured</label><br>
                <input type="checkbox" name="is_featured" id="is_featured" value="1" {{ old('is_featured', $product->is_featured) ? 'checked' : '' }}> Yes
            </div>

            <div class="form-group">
                <label for="cat_id">Category <span class="text-danger">*</span></label>
                <select name="cat_id" id="cat_id" class="form-control">
                    <option value="">--Select any category--</option>
                    @foreach($categories as $cat_data)
                        <option value="{{ $cat_data->_id }}" {{ old('cat_id', $product->cat_id) == $cat_data->_id ? 'selected' : '' }}>{{ $cat_data->title }}</option>
                    @endforeach
                </select>
                @error('cat_id')
                <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>

            <div class="form-group d-none" id="child_cat_div">
                <label for="child_cat_id">Sub Category</label>
                <select name="child_cat_id" id="child_cat_id" class="form-control">
                    <option value="">--Select any sub category--</option>
                    <!-- JS will fill -->
                </select>
            </div>

            <div class="form-group">
                <label for="brand_id">Brand</label>
                <select name="brand_id" class="form-control">
                    <option value="">--Select Brand--</option>
                    @foreach($brands as $brand)
                        <option value="{{ $brand->_id }}" {{ old('brand_id', $product->brand_id) == $brand->_id ? 'selected' : '' }}>{{ $brand->title }}</option>
                    @endforeach
                </select>
                @error('brand_id')
                <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>

            <div class="form-group">
                <label for="status" class="col-form-label">Status <span class="text-danger">*</span></label>
                <select name="status" class="form-control">
                    <option value="active" {{ old('status', $product->status) == 'active' ? 'selected' : '' }}>Active</option>
                    <option value="inactive" {{ old('status', $product->status) == 'inactive' ? 'selected' : '' }}>Inactive</option>
                </select>
                @error('status')
                <span class="text-danger">{{ $message }}</span>
                @enderror
            </div>

            <div class="form-group mb-3">
                <button class="btn btn-success" type="submit">Update</button>
            </div>
        </form>
    </div>
</div>
@endsection

@push('styles')
<link rel="stylesheet" href="{{ asset('backend/summernote/summernote.min.css') }}">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/css/bootstrap-select.css">
@endpush

@push('scripts')
<script src="{{ asset('vendor/laravel-filemanager/js/stand-alone-button.js') }}"></script>
<script src="{{ asset('backend/summernote/summernote.min.js') }}"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.1/js/bootstrap-select.min.js"></script>

<script>
    $(document).ready(function() {
        $('#lfm').filemanager('image', {prefix: '{{ url("laravel-filemanager") }}'});
        $('#summary').summernote({
            placeholder: "Write short description.....",
            tabsize: 2,
            height: 100
        });
        $('#description').summernote({
            placeholder: "Write detail description.....",
            tabsize: 2,
            height: 150
        });
        $('.selectpicker').selectpicker();
    });

    $('#cat_id').change(function(){
        var cat_id = $(this).val();
        if(cat_id != null){
            $.ajax({
                url: "/admin/category/" + cat_id + "/child",
                data: {
                    _token: "{{ csrf_token() }}",
                    id: cat_id
                },
                type: "POST",
                success: function(response){
                    var html_option = "<option value=''>----Select sub category----</option>";
                    if (response.status) {
                        var data = response.data;
                        if (data) {
                            $('#child_cat_div').removeClass('d-none');
                            $.each(data, function(id, title){
                                html_option += "<option value='" + id + "'>" + title + "</option>";
                            });
                        }
                    } else {
                        $('#child_cat_div').addClass('d-none');
                    }
                    $('#child_cat_id').html(html_option);
                }
            });
        }
    });
</script>
@endpush
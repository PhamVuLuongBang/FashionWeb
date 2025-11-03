@extends('backend.layouts.master')

@section('main-content')
<div class="card shadow mb-4">
    <div class="row">
        <div class="col-md-12">
            @include('backend.layouts.notification')
        </div>
    </div>
    <div class="card-header py-3">
        <h6 class="m-0 font-weight-bold text-primary float-left">Product Lists</h6>
        <a href="{{ route('admin.product.create') }}" class="btn btn-primary btn-sm float-right" data-toggle="tooltip" data-placement="bottom" title="Add Product">
            <i class="fas fa-plus"></i> Add Product
        </a>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            @if($products->count() > 0)
            <table class="table table-bordered" id="product-dataTable" width="100%" cellspacing="0">
                <thead>
                    <tr>
                        <th>S.N.</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Is Featured</th>
                        <th>Price</th>
                        <th>Discount</th>
                        <th>Size</th>
                        <th>Condition</th>
                        <th>Brand</th>
                        <th>Stock</th>
                        <th>Photo</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($products as $product)
                    <tr>
                        <td>{{ $loop->iteration }}</td>
                        <td>{{ $product->title }}</td>
                        <td>
                            {{ $product->cat_info?->title ?? '—' }}
                            <sub>{{ $product->sub_cat_info?->title ?? '' }}</sub>
                        </td>
                        <td>{{ $product->is_featured ? 'Yes' : 'No' }}</td>
                        <td>Rs. {{ number_format($product->price, 2) }} /-</td>
                        <td>{{ $product->discount ?? 0 }}% OFF</td>
                        <td>
                            @php
                                $sizes = $product->size ?? [];
                                $sizes = is_array($sizes) ? $sizes : [];
                            @endphp
                            {{ implode(', ', $sizes) }}
                        </td>
                        <td>{{ ucfirst($product->condition) }}</td>
                        <td>{{ $product->brand?->title ?? '—' }}</td>
                        <td>
                            <span class="badge badge-{{ $product->stock > 0 ? 'primary' : 'danger' }}">
                                {{ $product->stock }}
                            </span>
                        </td>
                        <td>
                            @php
                                $photoUrl = null;
                                $photo = $product->getRawOriginal('photo');

                                if (is_string($photo) && !empty(trim($photo))) {
                                    $photo = trim($photo);
                                    $photoUrl = \Illuminate\Support\Str::startsWith($photo, ['http://', 'https://', '/'])
                                        ? $photo
                                        : asset($photo);
                                } elseif (is_array($photo) && count($photo) > 0) {
                                    $first = $photo[0];
                                    $photoUrl = \Illuminate\Support\Str::startsWith($first, ['http://', 'https://', '/'])
                                        ? $first
                                        : asset($first);
                                }

                                $photoUrl = $photoUrl ?? asset('backend/img/thumbnail-default.jpg');
                            @endphp
                            <img src="{{ $photoUrl }}" class="img-fluid zoom" style="max-width:80px" alt="{{ $product->title }}">
                        </td>
                        <td>
                            <span class="badge badge-{{ $product->status == 'active' ? 'success' : 'warning' }}">
                                {{ ucfirst($product->status) }}
                            </span>
                        </td>
                        <td>
                            <a href="{{ route('admin.product.edit', $product->_id) }}" class="btn btn-primary btn-sm" style="height:30px;width:30px;border-radius:50%" title="Edit">
                                <i class="fas fa-edit"></i>
                            </a>
                            <form method="POST" action="{{ route('admin.product.destroy', $product->_id) }}" style="display:inline">
                                @csrf
                                @method('DELETE')
                                <button type="submit" class="btn btn-danger btn-sm dltBtn" data-id="{{ $product->_id }}" style="height:30px;width:30px;border-radius:50%" title="Delete">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
            <span style="float:right">{{ $products->links() }}</span>
            @else
                <h6 class="text-center">No Products found!!! Please create Product</h6>
            @endif
        </div>
    </div>
</div>
@endsection

@push('styles')
<link href="{{ asset('backend/vendor/datatables/dataTables.bootstrap4.min.css') }}" rel="stylesheet">
<style>
    div.dataTables_wrapper div.dataTables_paginate { display: none; }
    .zoom { transition: transform .2s; }
    .zoom:hover { transform: scale(5); }
</style>
@endpush

@push('scripts')
<script src="{{ asset('backend/vendor/datatables/jquery.dataTables.min.js') }}"></script>
<script src="{{ asset('backend/vendor/datatables/dataTables.bootstrap4.min.js') }}"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

<script>
    $('#product-dataTable').DataTable({
        "scrollX": false,
        "columnDefs": [{ "orderable": false, "targets": [10,11,12] }]
    });

    $(document).ready(function(){
        $.ajaxSetup({
            headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }
        });

        $('.dltBtn').click(function(e){
            e.preventDefault();
            var form = $(this).closest('form');
            swal({
                title: "Are you sure?",
                text: "Once deleted, you will not be able to recover this data!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
            .then((willDelete) => {
                if (willDelete) form.submit();
                else swal("Your data is safe!");
            });
        });
    });
</script>
@endpush
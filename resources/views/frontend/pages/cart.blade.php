@extends('frontend.layouts.master')
@section('title','TEAM 7 || Cart Page')
@section('main-content')
	<!-- Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="bread-inner">
						<ul class="bread-list">
							<li><a href="{{('home')}}">Home<i class="ti-arrow-right"></i></a></li>
							<li class="active"><a href="">Cart</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->

	<!-- Shopping Cart -->
	<div class="shopping-cart section">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<!-- Shopping Summery -->
					<table class="table shopping-summery">
						<thead>
							<tr class="main-hading">
								<th>PRODUCT</th>
								<th>NAME</th>
								<th class="text-center">UNIT PRICE</th>
								<th class="text-center">QUANTITY</th>
								<th class="text-center">TOTAL</th>
								<th class="text-center"><i class="ti-trash remove-icon"></i></th>
							</tr>
						</thead>
						<tbody id="cart_item_list">
							<form action="{{route('cart.update')}}" method="POST">  <!-- Giữ nguyên form update -->
								@csrf
								@if($carts->isNotEmpty())  <!-- THAY ĐỔI: Dùng $carts từ controller thay vì Helper -->
									@foreach($carts as $cart)
										<tr>
											@php
											$photo=explode(',',$cart->product->photo);  // Giữ nguyên, dùng $cart->product (relationship)
											@endphp
											<td class="image" data-title="No"><img src="{{$photo[0]}}" alt="{{$photo[0]}}"></td>
											<td class="product-des" data-title="Description">
												<p class="product-name"><a href="{{route('product-detail',$cart->product->slug)}}" target="_blank">{{$cart->product->title}}</a></p>
												<p class="product-des">{{$cart->product->summary}}</p>  <!-- Giữ nếu cần, hoặc xóa nếu không -->
											</td>
											<td class="price" data-title="Price"><span>{{number_format($cart->price)}} VNĐ</span></td>  <!-- THAY ĐỔI: Dùng $cart->price -->
											<td class="qty" data-title="Qty"><!-- Input Number -->
												<div class="input-group">
													<div class="button minus">
														<button type="button" class="btn btn-primary btn-number" data-type="minus" data-field="quant[{{$loop->iteration}}]">
															<i class="ti-minus"></i>
														</button>
													</div>
													<input type="hidden" name="qty_id[]" value="{{$cart->id}}">  <!-- THAY ĐỔI: Dùng $cart->id cho qty_id -->
													<input type="text" name="quant[]" class="input-number"  data-min="1" data-max="{{$cart->product->stock}}" value="{{$cart->quantity}}">  <!-- THAY ĐỔI: Dùng $cart->quantity -->
													<div class="button plus">
														<button type="button" class="btn btn-primary btn-number" data-type="plus" data-field="quant[{{$loop->iteration}}]">
															<i class="ti-plus"></i>
														</button>
													</div>
												</div>
												<!--/ End Input Number -->
											</td>
											<td class="total-amount cart_single_total" data-title="Total"><span class="money">{{number_format($cart->amount)}} VNĐ</span></td>  <!-- THAY ĐỔI: Dùng $cart->amount -->
											<td class="action" data-title="Remove">
												<form action="{{route('cart.delete')}}" method="POST">  <!-- THAY ĐỔI: Sử dụng form delete với route cart.delete -->
													@csrf
													<input type="hidden" name="id" value="{{$cart->id}}">
													<button type="submit" class="btn btn-link text-danger"><i class="ti-trash remove-icon"></i></button>
												</form>
											</td>
										</tr>
									@endforeach
									<tr>
										<td colspan="6" class="text-right">
											<button type="submit" class="btn">Update</button>  <!-- Nút submit form update -->
										</td>
									</tr>
								@else
									<tr>
										<td colspan="6"><p class="text-center">Giỏ hàng trống.</p></td>
									</tr>
								@endif
							</form>
						</tbody>
					</table>
					<!--/ End Shopping Summery -->
				</div>
			</div>
			<div class="row">
				<div class="col-12">
					<!-- Total Amount -->
					<div class="total-amount">
						<div class="row">
							<div class="col-lg-8 col-md-5 col-12">
								<div class="left">
									<div class="coupon">
										<form action="{{route('coupon.store')}}" method="POST">  <!-- Giữ nguyên phần coupon nếu bạn có -->
											@csrf
											<input name="code" placeholder="Enter Your Coupon">
											<button class="btn" type="submit">Apply</button>
										</form>
									</div>
									<div class="checkbox">
										<div class="shipping-form">  <!-- Giữ nguyên phần shipping nếu cần -->
											<div class="row">
												@foreach(Helper::shipping() as $shipping)
													<div class="col-6">
														<a href="#" class="btn">{{$shipping->type}}: ${{number_format($shipping->price)}}<input type="hidden" value="{{$shipping->price}}"></a>
													</div>
												@endforeach
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-lg-4 col-md-7 col-12">
								<div class="right">
									<ul>
										<li>Cart Subtotal<span>{{number_format($sub_total)}} VNĐ</span></li>  <!-- THAY ĐỔI: Dùng $sub_total từ controller -->
										<li>Shipping<span>Free</span></li>  <!-- Nếu có phí ship, tính thêm vào controller -->
										<li>You Save<span>{{number_format(0)}} VNĐ</span></li>  <!-- Nếu có discount, thêm logic controller -->
										<li class="last">You Pay<span>{{number_format($total)}} VNĐ</span></li>  <!-- THAY ĐỔI: Dùng $total -->
									</ul>
									<div class="button5">
										<a href="{{route('checkout')}}" class="btn">Checkout</a>  <!-- Giữ nguyên route checkout -->
										<a href="{{route('home')}}" class="btn">Continue shopping</a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--/ End Total Amount -->
				</div>
			</div>
		</div>
	</div>
	<!--/ End Shopping Cart -->

	<!-- Start Shop Services Area  -->
	<section class="shop-services section home">
		<div class="container">
			<div class="row">
				<div class="col-lg-3 col-md-6 col-12">
					<!-- Start Single Service -->
					<div class="single-service">
						<i class="ti-rocket"></i>
						<h4>Free shiping</h4>
						<p>Orders over $100</p>
					</div>
					<!-- End Single Service -->
				</div>
				<div class="col-lg-3 col-md-6 col-12">
					<!-- Start Single Service -->
					<div class="single-service">
						<i class="ti-reload"></i>
						<h4>Free Return</h4>
						<p>Within 30 days returns</p>
					</div>
					<!-- End Single Service -->
				</div>
				<div class="col-lg-3 col-md-6 col-12">
					<!-- Start Single Service -->
					<div class="single-service">
						<i class="ti-lock"></i>
						<h4>Sucure Payment</h4>
						<p>100% secure payment</p>
					</div>
					<!-- End Single Service -->
				</div>
				<div class="col-lg-3 col-md-6 col-12">
					<!-- Start Single Service -->
					<div class="single-service">
						<i class="ti-tag"></i>
						<h4>Best Peice</h4>
						<p>Guaranteed price</p>
					</div>
					<!-- End Single Service -->
				</div>
			</div>
		</div>
	</section>
	<!-- End Shop Newsletter -->

	<!-- Start Shop Newsletter  -->
	@include('frontend.layouts.newsletter')
	<!-- End Shop Newsletter -->

@endsection
@push('styles')
	<style>
		li.shipping{
			display: inline-flex;
			width: 100%;
			font-size: 14px;
		}
		li.shipping .input-group-icon {
			width: 100%;
			margin-left: 10px;
		}
		.input-group-icon .icon {
			position: absolute;
			left: 20px;
			top: 0;
			line-height: 40px;
			z-index: 3;
		}
		.form-select {
			height: 30px;
			width: 100%;
		}
		.form-select .nice-select {
			border: none;
			border-radius: 0px;
			height: 40px;
			background: #f6f6f6 !important;
			padding-left: 45px;
			padding-right: 40px;
			width: 100%;
		}
		.list li{
			margin-bottom:0 !important;
		}
		.list li:hover{
			background:#F7941D !important;
			color:white !important;
		}
		.form-select .nice-select::after {
			top: 14px;
		}
	</style>
@endpush
@push('scripts')
	<script src="{{asset('frontend/js/nice-select/js/jquery.nice-select.min.js')}}"></script>
	<script src="{{ asset('frontend/js/select2/js/select2.min.js') }}"></script>
	<script>
		$(document).ready(function() { $("select.select2").select2(); });
  		$('select.nice-select').niceSelect();
	</script>
	<script>
		$(document).ready(function(){
			$('.shipping select[name=shipping]').change(function(){
				let cost = parseFloat( $(this).find('option:selected').data('price') ) || 0;
				let subtotal = parseFloat( $('.order_subtotal').data('price') );
				let coupon = parseFloat( $('.coupon_price').data('price') ) || 0;
				// alert(coupon);
				$('#order_total_price span').text('$'+(subtotal + cost-coupon).toFixed(2));
			});

		});

	</script>

@endpush
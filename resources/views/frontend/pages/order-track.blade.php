@extends('frontend.layouts.master')

@section('title','TEAM 7 || Order Track Page')

@section('main-content')
    <!-- Breadcrumbs -->
    <div class="breadcrumbs">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="bread-inner">
                        <ul class="bread-list">
                            <li><a href="{{ route('home') }}">Home <i class="ti-arrow-right"></i></a></li>
                            <li class="active"><a href="javascript:void(0);">Order Track</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Breadcrumbs -->

    <section class="tracking_box_area section_gap py-5">
        <div class="container">
            <div class="tracking_box_inner">
                <p>Nhập mã đơn hàng của bạn vào ô bên dưới và nhấn nút "Track". Mã này có trên biên nhận hoặc email xác nhận của bạn.</p>
                
                <form class="row tracking_form my-4" action="{{ route('product.track.order') }}" method="post" novalidate="novalidate">
                    @csrf
                    <div class="col-md-8 form-group">
                        <input type="text" class="form-control p-2" name="order_number" placeholder="Nhập mã đơn hàng">
                    </div>
                    <div class="col-md-8 form-group">
                        <button type="submit" class="btn submit_btn">Track Order</button>
                    </div>
                </form>

                <!-- Google Map hiển thị vị trí đơn hàng -->
                <div class="mapouter mt-4">
                    <div id="map" style="height: 400px; width: 100%;"></div>
                </div>
            </div>
        </div>
    </section>
@endsection

@section('scripts')
    <!-- Google Maps API với ngôn ngữ tiếng Việt -->
    <script src="https://maps.googleapis.com/maps/api/js?key={{ env('GOOGLE_MAPS_API_KEY') }}&language=vi"></script>
    <script>
        function initMap() {
            // Vị trí mặc định (ví dụ Hà Nội)
            var defaultLocation = { lat: 21.0278, lng: 105.8342 };

            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 12,
                center: defaultLocation
            });

            var marker = new google.maps.Marker({
                position: defaultLocation,
                map: map,
                title: 'Vị trí đơn hàng'
            });
        }

        // Khởi tạo map khi load trang
        google.maps.event.addDomListener(window, 'load', initMap);
    </script>
@endsection

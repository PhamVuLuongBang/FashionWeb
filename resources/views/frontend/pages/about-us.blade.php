@extends('frontend.layouts.master')

@section('title','TEAM 7 || About Us')

@section('main-content')

<!-- Breadcrumbs -->
<div class="breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="bread-inner">
                    <ul class="bread-list">
                        <li><a href="{{route('home')}}">Home<i class="ti-arrow-right"></i></a></li>
                        <li class="active"><a href="#">About Us</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Breadcrumbs -->

<!-- About Us -->
<section class="about-us section">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-12">
                <div class="about-content">
                    @php
                        $settings = \App\Models\Settings::first();
                    @endphp
                    <h3>Welcome To <span>TEAM 7</span></h3>
                    <p>{{ $settings->description ?? '' }}</p>
                    <div class="button">
                        <a href="{{route('blog')}}" class="btn">Our Blog</a>
                        <a href="{{route('contact')}}" class="btn primary">Contact Us</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-6 col-12">
                <div class="about-img overlay">
                    <img src="{{ $settings->photo }}" alt="About Us">
                </div>
            </div>
        </div>
    </div>
</section>
<!-- End About Us -->

<!-- Google Map Section -->
<section class="map-section section">
    <div class="container">
        <h3 class="text-center mb-4">Our Locations</h3>
        <div id="map" style="width: 100%; height: 900px;"></div>
    </div>
</section>

<!-- Google Maps Script -->
<script>
    function initMap() {
        const congThuong = { lat: 10.8222, lng: 106.6865 };
        const bachKhoa = { lat: 10.7722, lng: 106.6570 };

        const map = new google.maps.Map(document.getElementById("map"), {
            zoom: 13,
            center: congThuong,
            mapTypeControl: true,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        });

        const bounds = new google.maps.LatLngBounds();
        bounds.extend(congThuong);
        bounds.extend(bachKhoa);
        map.fitBounds(bounds);

        const info1 = new google.maps.InfoWindow({
            content: "<strong>Đại học Công Thương</strong><br>Biểu tượng địa chỉ shop 1"
        });
        const info2 = new google.maps.InfoWindow({
            content: "<strong>Đại học Bách Khoa</strong><br>Biểu tượng địa chỉ shop 2"
        });

        const marker1 = new google.maps.Marker({
            position: congThuong,
            map,
            title: "ĐH Công Thương",
            icon: "http://maps.google.com/mapfiles/ms/icons/red-dot.png"
        });
        const marker2 = new google.maps.Marker({
            position: bachKhoa,
            map,
            title: "ĐH Bách Khoa",
            icon: "http://maps.google.com/mapfiles/ms/icons/red-dot.png"
        });

        marker1.addListener("click", () => info1.open(map, marker1));
        marker2.addListener("click", () => info2.open(map, marker2));

        // Định vị người dùng
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition((position) => {
                const userLocation = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };
                new google.maps.Marker({
                    position: userLocation,
                    map,
                    title: "Vị trí của bạn",
                    icon: "http://maps.google.com/mapfiles/ms/icons/blue-dot.png"
                });
            });
     }

        // Tùy chỉnh màu sắc bản đồ
        const styledMapType = new google.maps.StyledMapType([
            {
                featureType: "all",
                elementType: "labels.text.fill",
                stylers: [{ color: "#ffffff" }]
            },
            {
                featureType: "all",
                elementType: "labels.text.stroke",
                stylers: [{ color: "#000000" }]
            }
        ], { name: "Styled Map" });

        map.mapTypes.set("styled_map", styledMapType);
        map.setMapTypeId("styled_map");
    }
</script>

<!-- Load Google Maps API -->
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC0lbi0RPIOQwgjSeFKYyGGP1uPG0gxRlo&callback=initMap">
</script>

<!-- Start Shop Services Area -->
<section class="shop-services section">
    <div class="container">
        <div class="row">
            <div class="col-lg-3 col-md-6 col-12">
                <div class="single-service">
                    <i class="ti-rocket"></i>
                    <h4>Free Shipping</h4>
                    <p>Orders over $100</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-12">
                <div class="single-service">
                    <i class="ti-reload"></i>
                    <h4>Free Return</h4>
                    <p>Within 30 days returns</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-12">
                <div class="single-service">
                    <i class="ti-lock"></i>
                    <h4>Secure Payment</h4>
                    <p>100% secure payment</p>
                </div>
            </div>
            <div class="col-lg-3 col-md-6 col-12">
                <div class="single-service">
                    <i class="ti-tag"></i>
                    <h4>Best Price</h4>
                    <p>Guaranteed price</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- End Shop Services Area -->

@include('frontend.layouts.newsletter')
@endsection

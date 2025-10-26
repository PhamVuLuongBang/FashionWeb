<div id="notifications">
    <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <i class="fas fa-bell fa-fw"></i>
        <span class="badge badge-danger badge-counter">
            @if(Auth::check() && Auth::user()->unreadNotifications->count() > 5)
                <span data-count="5" class="count">5+</span>
            @elseif(Auth::check())
                <span class="count" data-count="{{ Auth::user()->unreadNotifications->count() }}">
                    {{ Auth::user()->unreadNotifications->count() }}
                </span>
            @else
                <span class="count" data-count="0">0</span>
            @endif
        </span>
    </a>

    <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
        <h6 class="dropdown-header">Notifications Center</h6>

        @if(Auth::check())
            @foreach(Auth::user()->unreadNotifications->take(5) as $notification)
                <a class="dropdown-item d-flex align-items-center" target="_blank" href="{{ route('admin.notification', $notification->id) }}">
                    <div class="mr-3">
                        <div class="icon-circle bg-primary">
                            <i class="fas {{ $notification->data['fas'] ?? 'fa-info' }} text-white"></i>
                        </div>
                    </div>
                    <div>
                        <div class="small text-gray-500">
                            {{ $notification->created_at->format('F d, Y h:i A') }}
                        </div>
                        <span class="@if($notification->read_at === null) font-weight-bold @else text-gray-500 @endif">
                            {{ $notification->data['title'] ?? 'Notification' }}
                        </span>
                    </div>
                </a>
            @endforeach
        @else
            <a class="dropdown-item text-center small text-gray-500">Please login to see notifications</a>
        @endif

        <a class="dropdown-item text-center small text-gray-500" href="{{ route('all.notification') }}">
            Show All Notifications
        </a>
    </div>
</div>
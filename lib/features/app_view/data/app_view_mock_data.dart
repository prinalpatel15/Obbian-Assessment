import '../../../core/constants/app_assets.dart';
import 'models/media_card_item.dart';
import 'models/recent_place.dart';
import 'models/ride_nav_item.dart';

/// Static content copied verbatim from the design. Swap for an API later.
abstract final class AppViewMockData {
  static const currentCity = 'New City';

  static const recentPlaces = [
    RecentPlace(
      title: 'Junwani Rd',
      address: 'near Apollo Hospital, Smriti Nagar, Surya Vihar, Bhilai',
      distance: '4.3 km',
    ),
    RecentPlace(
      title: 'Bus Stand',
      address: 'Civil Lines, Durg, Chhattisgarh 491001, India',
      distance: '1.3 km',
    ),
    RecentPlace(
      title: 'Santpali cg',
      address: 'Camp 2, Bhanwarpur, Chhattisgarh 493555, India',
      distance: '9 km',
    ),
  ];

  static const explorePlaces = [
    MediaCardItem(image: AppAssets.exploreRamoji),
    MediaCardItem(image: AppAssets.exploreCharminar),
  ];

  // "Buisness" is spelled as in the design - fix once copy is confirmed.
  static const neighborhood = [
    MediaCardItem(
      image: AppAssets.hoodConstruction,
      title: 'Scale your Buisness\nwith us',
      isVideo: true,
    ),
    MediaCardItem(
      image: AppAssets.hoodMarket,
      title: 'Connecting and\ngrowing',
      isVideo: true,
    ),
  ];

  // The design labels the last two tabs "Ride 3" - kept as-is.
  static const navItems = [
    RideNavItem(image: AppAssets.navCar, label: 'Ride 1'),
    RideNavItem(image: AppAssets.navAuto, label: 'Ride 2'),
    RideNavItem(image: AppAssets.navScooter, label: 'Ride 3'),
    RideNavItem(image: AppAssets.navBike, label: 'Ride 3'),
  ];
}

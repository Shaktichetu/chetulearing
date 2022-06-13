const GOOGLE_API_KEY = 'AIzaSyDX8RaIygVijIHzTbuvVjV9f15G8LF3Ndw';

class LocationHelper {
  static String generateLocationPreviewImage({double latitude = 28.628223, double longitude = 77.389849,}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
    
  }
}
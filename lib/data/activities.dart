class Category {
  String? id;
  String? title;
  String? imageUrl;

  Category({this.id, this.title, this.imageUrl});
}

List<Category> allCategories = [
  Category(
    id: 'c1',
    title: 'Mountains', // جبال
    imageUrl:
        'https://images.unsplash.com/photo-1575728252059-db43d03fc2de?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NTh8fG1vdW5hdGluc3xlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=',
  ),
  Category(
    id: 'c2',
    title: 'Lakes', // بحيرات
    imageUrl:
        'https://images.unsplash.com/photo-1501785888041-af3ef285b470?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
  ),
  Category(
    id: 'c3',
    title: 'Beaches', // شواطىء
    imageUrl:
        'https://images.unsplash.com/photo-1493558103817-58b2924bce98?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTAxfHxiZWFjaHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
  ),
  Category(
    id: 'c4',
    title: 'Deserts', // صحارى
    imageUrl:
        'https://images.unsplash.com/photo-1473580044384-7ba9967e16a0?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGVzZXJ0fGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
  ),
  Category(
    id: 'c5',
    title: 'Historic Cities', // مدن تاريخية
    imageUrl:
        'https://images.unsplash.com/photo-1467269204594-9661b134dd2b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NjR8fHRyYXZlbHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
  ),
  Category(
    id: 'c6',
    title: 'Other', // Other (already in English)
    imageUrl:
        'https://images.unsplash.com/photo-1605540436563-5bca919ae766?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c2tpaW5nfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60',
  ),
];

class Activity {
  String? id;
  List<String>? categories;
  String? title;
  String? imageUrl;
  List<String>? images;
  List<String>? activities;
  List<String>? program;
  int? duration;
  String? season;
  String? activityType;
  bool? isInSummer;
  bool? isInWinter;
  bool? isForFamilies;

  Activity({
    this.id,
    this.categories,
    this.title,
    this.imageUrl,
    this.images,
    this.activities,
    this.program,
    this.duration,
    this.season,
    this.activityType,
    this.isInSummer,
    this.isInWinter,
    this.isForFamilies,
  });
}

List<Activity> allActivities = [
  Activity(
    id: 'm1',
    categories: ['c1'],
    title: 'Alps Mountains',
    activityType: 'Exploration',
    season: 'Winter',
    images: [
      'https://images.unsplash.com/photo-1714987506730-0e486235460f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fEFscHMlMjBNb3VudGFpbnN8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1655388613924-38ff15c98a3c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fEFscHMlMjBNb3VudGFpbnN8ZW58MHx8MHx8fDA%3D',
      'https://plus.unsplash.com/premium_photo-1688327889689-46526412bc98?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fEFscHMlMjBNb3VudGFpbnN8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1654763614619-43ca2571a114?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fEFscHMlMjBNb3VudGFpbnN8ZW58MHx8MHx8fDA%3D',
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1611523658822-385aa008324c?ixid=MXwxMjA3fDB8MHxzZWFyY2h8N3x8bW91bmF0aW5zfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    duration: 20,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore.',
      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia.',
    ],
    isInSummer: false,
    isForFamilies: true,
    isInWinter: true,
  ),
  Activity(
    id: 'm2',
    categories: ['c1'],
    title: 'Southern Mountains',
    activityType: 'Exploration',
    season: 'Winter',
    images: [
      'https://images.unsplash.com/photo-1619202807240-576fefaa4e98?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8U291dGhlcm4lMjBNb3VudGFpbnN8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1611443764455-40361467aa52?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8U291dGhlcm4lMjBNb3VudGFpbnN8ZW58MHx8MHx8fDA%3D',
      'https://plus.unsplash.com/premium_photo-1667697774362-8b7bb9b7bcd5?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fFNvdXRoZXJuJTIwTW91bnRhaW5zfGVufDB8fDB8fHwwhttps://plus.unsplash.com/premium_photo-1667697774362-8b7bb9b7bcd5?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fFNvdXRoZXJuJTIwTW91bnRhaW5zfGVufDB8fDB8fHww',
      'https://plus.unsplash.com/premium_photo-1694475644616-8a68e8c1bab4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fFNvdXRoZXJuJTIwTW91bnRhaW5zfGVufDB8fDB8fHww'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1612456225451-bb8d10d0131d?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjZ8fG1vdW5hdGluc3xlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    duration: 10,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: false,
    isForFamilies: false,
    isInWinter: false,
  ),
  Activity(
    id: 'm3',
    categories: ['c1'],
    title: 'High Mountains',
    activityType: 'Recovery',
    season: 'Winter',
    images: [
      'https://images.unsplash.com/photo-1598363692564-cfb9292ff710?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8SGlnaCUyME1vdW50YWluc3xlbnwwfHwwfHx8MA%3D%3D',
      'https://plus.unsplash.com/premium_photo-1675629119773-ba2f82432e11?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8SGlnaCUyME1vdW50YWluc3xlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1594547121826-3445761d2ce5?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8SGlnaCUyME1vdW50YWluc3xlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1531329502962-4edcadcc64a1?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8SGlnaCUyME1vdW50YWluc3xlbnwwfHwwfHx8MA%3D%3D'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1592221912790-2b4df8882ea9?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mzd8fG1vdW5hdGluc3xlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    duration: 45,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: false,
    isForFamilies: false,
    isInWinter: true,
  ),
  Activity(
    id: 'm4',
    categories: ['c2', 'c1'],
    title: 'Great Lake',
    activityType: 'Activities',
    season: 'Spring',
    images: [
      'https://plus.unsplash.com/premium_photo-1744984306657-019258e4f467?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fEdyZWF0JTIwTGFrZXxlbnwwfHwwfHx8MA%3D%3D',
      'https://plus.unsplash.com/premium_photo-1664127684928-e149513f0a39?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8R3JlYXQlMjBMYWtlfGVufDB8fDB8fHww',
      'https://plus.unsplash.com/premium_photo-1744984306657-019258e4f467?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fEdyZWF0JTIwTGFrZXxlbnwwfHwwfHx8MA%3D%3D',
      'https://plus.unsplash.com/premium_photo-1664127685084-f89477fa05f0?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8R3JlYXQlMjBMYWtlfGVufDB8fDB8fHww'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?ixid=MXwxMjA3fDB8MHxzZWFyY2h8OXx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    duration: 60,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: false,
    isForFamilies: false,
    isInWinter: false,
  ),
  Activity(
    id: 'm5',
    categories: ['c2', 'c1'],
    title: 'Small Lakes',
    activityType: 'Activities',
    season: 'Winter',
    images: [
      'https://images.unsplash.com/photo-1655974097736-d600a23a756d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fFNtYWxsJTIwTGFrZXN8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1647959116516-4557950873d9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8U21hbGwlMjBMYWtlc3xlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1712637362068-8350f55b8304?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8U21hbGwlMjBMYWtlc3xlbnwwfHwwfHx8MA%3D%3D',
      'https://plus.unsplash.com/premium_photo-1669456606221-bf51af9cabe4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8U21hbGwlMjBMYWtlc3xlbnwwfHwwfHx8MA%3D%3D'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1580100586938-02822d99c4a8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjF8fGxha2V8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    duration: 15,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: true,
    isForFamilies: false,
    isInWinter: true,
  ),
  Activity(
    id: 'm6',
    categories: ['c2'],
    title: 'Emerald Lake',
    activityType: 'Exploration',
    season: 'Summer',
    images: [
      'https://plus.unsplash.com/premium_photo-1696233005540-c768b75bae95?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8RW1lcmFsZCUyMExha2V8ZW58MHx8MHx8fDA%3D',
      'https://plus.unsplash.com/premium_photo-1669689972709-c4a9a9a4cbbe?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8RW1lcmFsZCUyMExha2V8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1636886519725-6a048800b5b4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8RW1lcmFsZCUyMExha2V8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1562524029-acca99f1a6b1?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8RW1lcmFsZCUyMExha2V8ZW58MHx8MHx8fDA%3D'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1501785888041-af3ef285b470?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NHx8bGFrZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    duration: 240,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: true,
    isForFamilies: false,
    isInWinter: false,
  ),
  Activity(
    id: 'm7',
    categories: ['c3'],
    title: 'Skikda Beach',
    activityType: 'Exploration',
    season: 'Winter',
    images: [
      'https://plus.unsplash.com/premium_photo-1675431435428-33c25f818d67?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8QWxnZXJpYW4lMjBiZWFjaHxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1694046963948-e8e7ca91a7a6?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fEFsZ2VyaWFuJTIwYmVhY2h8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1660926252394-a306adb92fd5?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fEFsZ2VyaWFuJTIwYmVhY2h8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1603186227544-607d4a953b00?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fEFsZ2VyaWFuJTIwYmVhY2h8ZW58MHx8MHx8fDA%3D'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1493558103817-58b2924bce98?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTAxfHxiZWFjaHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    duration: 20,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: true,
    isForFamilies: false,
    isInWinter: false,
  ),
  Activity(
    id: 'm8',
    categories: ['c3'],
    title: 'Big Beach',
    activityType: 'Recovery',
    season: 'Spring',
    images: [
      'https://images.unsplash.com/photo-1694046963948-e8e7ca91a7a6?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fEFsZ2VyaWFuJTIwYmVhY2h8ZW58MHx8MHx8fDA%3D',
      'https://plus.unsplash.com/premium_photo-1668723712092-c9a5bca04743?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fEFsZ2VyaWFuJTIwYmVhY2h8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1598877541659-aa4c0a7fc268?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fEFsZ2VyaWFuJTIwYmVhY2h8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1633209438128-00d091e3dd09?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fEFsZ2VyaWFuJTIwYmVhY2h8ZW58MHx8MHx8fDA%3D'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1519046904884-53103b34b206?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Mnx8YmVhY2h8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    duration: 35,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: true,
    isForFamilies: false,
    isInWinter: true,
  ),
  Activity(
    id: 'm9',
    categories: ['c3'],
    title: 'Rocky Beach',
    activityType: 'Exploration',
    season: 'Summer',
    images: [
      'https://images.unsplash.com/photo-1647869485355-cd47cfddf755?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8YmVhY2glMjBhbGdlcmlhJTIwU2tpa2RhfGVufDB8fDB8fHww',
      'https://plus.unsplash.com/premium_photo-1664635401818-3a171967ab89?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fGJlYWNoJTIwYWxnZXJpYSUyMFNraWtkYXxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1712315481734-525327580110?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGJlYWNoJTIwYWxnZXJpYSUyMFNraWtkYXxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1591008445312-355b4b1bccd7?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fGJlYWNoJTIwYWxnZXJpYSUyMFNraWtkYXxlbnwwfHwwfHx8MA%3D%3D'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1519602035691-16ac091344ef?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MjE1fHxiZWFjaHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    duration: 45,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: true,
    isForFamilies: false,
    isInWinter: false,
  ),
  Activity(
    id: 'm10',
    categories: ['c4'],
    title: 'Great Desert',
    activityType: 'Activities',
    season: 'Winter',
    images: [
      'https://images.unsplash.com/photo-1602805977709-e6f21454afc1?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8R3JlYXQlMjBEZXNlcnR8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1646260740168-3c4e0e1faaf6?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8R3JlYXQlMjBEZXNlcnR8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1651143101564-46e52cd9e573?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fEdyZWF0JTIwRGVzZXJ0fGVufDB8fDB8fHww',
      'https://plus.unsplash.com/premium_photo-1673515786778-56a732133119?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8R3JlYXQlMjBEZXNlcnR8ZW58MHx8MHx8fDA%3D'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1473580044384-7ba9967e16a0?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8ZGVzZXJ0fGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    duration: 30,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: true,
    isForFamilies: true,
    isInWinter: true,
  ),
  Activity(
    id: 'm11',
    categories: ['c4', 'c1'],
    title: 'Western Desert',
    activityType: 'Activities',
    season: 'Winter',
    images: [
      'https://images.unsplash.com/photo-1708005774733-17e172186c18?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8V2VzdGVybiUyMERlc2VydHxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1593663128403-9db609542c2e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8V2VzdGVybiUyMERlc2VydHxlbnwwfHwwfHx8MA%3D%3D',
      'https://plus.unsplash.com/premium_photo-1674657843317-3ecb78dc544d?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8V2VzdGVybiUyMERlc2VydHxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1707468843072-aa7d6b394b2b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fFdlc3Rlcm4lMjBEZXNlcnR8ZW58MHx8MHx8fDA%3D'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTB8fHRyYXZlbHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    duration: 30,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: true,
    isForFamilies: true,
    isInWinter: true,
  ),
  Activity(
    id: 'm12',
    categories: ['c4'],
    title: 'Sandy Desert',
    activityType: 'Activities',
    season: 'Winter',
    images: [
      'https://images.unsplash.com/photo-1559963094-152915945638?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8U2FuZHklMjBEZXNlcnR8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1599131928308-3600fac5d8e2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fFNhbmR5JTIwRGVzZXJ0fGVufDB8fDB8fHww',
      'https://images.unsplash.com/photo-1562491886-e711c69a4d73?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fFNhbmR5JTIwRGVzZXJ0fGVufDB8fDB8fHww',
      
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1452022582947-b521d8779ab6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8ODN8fGRlc2VydHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    duration: 30,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: true,
    isForFamilies: true,
    isInWinter: true,
  ),
  Activity(
    id: 'm13',
    categories: ['c5'],
    title: 'Algeria-Setif',
    activityType: 'Activities',
    season: 'Winter',
    images: [
      'https://images.unsplash.com/photo-1572906487717-0a7a6dc0ea7e?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cyVDMyVBOXRpZnxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1642956180207-dfd244bc995b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fHMlQzMlQTl0aWZ8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1580817706565-46f8e58b4cd4?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cyVDMyVBOXRpZnxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1637270837622-020838986c86?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8U2V0aWYlMjBBbGdlcmlhfGVufDB8fDB8fHww'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1498307833015-e7b400441eb8?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NDJ8fHRyYXZlbHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    duration: 30,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: true,
    isForFamilies: true,
    isInWinter: true,
  ),
  Activity(
    id: 'm14',
    categories: ['c5'],
    title: 'Algeria-Oran',
    activityType: 'Activities',
    season: 'Winter',
    images: [
      'https://images.unsplash.com/photo-1642658456519-797bb59f1a88?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fE9yYW58ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1723225825416-846f196237aa?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fE9yYW58ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1698157810207-8748b04962c9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fE9yYW58ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1656978310683-d415ee895c2c?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8T3JhbnxlbnwwfHwwfHx8MA%3D%3D'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1467269204594-9661b134dd2b?ixid=MXwxMjA3fDB8MHxzZWFyY2h8NjR8fHRyYXZlbHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    duration: 30,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: true,
    isForFamilies: true,
    isInWinter: true,
  ),
  Activity(
    id: 'm15',
    categories: ['c5'],
    title: 'Roma',
    activityType: 'Activities',
    season: 'Winter',
    images: [
      'https://images.unsplash.com/photo-1509024644558-2f56ce76c490?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fFJvbWF8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1569759276108-31b8e7e43e7b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fFJvbWF8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1626285220266-e35bd313d05b?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fFJvbWF8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1569230516306-5a8cb5586399?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Um9tYXxlbnwwfHwwfHx8MA%3D%3D',
      'https://plus.unsplash.com/premium_photo-1675975706513-9daba0ec12a8?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Um9tYXxlbnwwfHwwfHx8MA%3D%3D'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1519923041107-e4dc8d9193da?ixid=MXwxMjA3fDB8MHxzZWFyY2h8Njd8fG9sZCUyMGNpdHl8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    duration: 30,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: true,
    isForFamilies: true,
    isInWinter: true,
  ),
  Activity(
    id: 'm16',
    categories: ['c6'],
    title: 'Snow Sports',
    activityType: 'Activities',
    season: 'Winter',
    images: [
      'https://images.unsplash.com/photo-1672437738193-cb484d5e2831?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8U25vdyUyMFNwb3J0fGVufDB8fDB8fHww',
      'https://images.unsplash.com/photo-1547341124-ab8b68766eba?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fFNub3clMjBTcG9ydHxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1614366408041-c5db93ff44f3?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fFNub3clMjBTcG9ydHxlbnwwfHwwfHx8MA%3D%3D',
      'https://images.unsplash.com/photo-1672437737290-f9e1e2df7461?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fFNub3clMjBTcG9ydHxlbnwwfHwwfHx8MA%3D%3D'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1605540436563-5bca919ae766?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MXx8c2tpaW5nfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    duration: 30,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: true,
    isForFamilies: true,
    isInWinter: true,
  ),
  Activity(
    id: 'm17',
    categories: ['c6', 'c2'],
    title: 'Parachute Jumping',
    activityType: 'Activities',
    season: 'Winter',
    images: [
      'https://images.unsplash.com/photo-1562545624-5d26bcdda105?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fFBhcmFjaHV0ZSUyMEp1bXBpbmd8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1571487998925-0e82e1314abe?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fFBhcmFjaHV0ZSUyMEp1bXBpbmd8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1665858843828-384327053055?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fFBhcmFjaHV0ZSUyMEp1bXBpbmd8ZW58MHx8MHx8fDA%3D',
      'https://images.unsplash.com/photo-1730358847065-060c2d910f82?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8UGFyYWNodXRlJTIwSnVtcGluZ3xlbnwwfHwwfHx8MA%3D%3D'
    ],
    imageUrl:
        'https://images.unsplash.com/photo-1601024445121-e5b82f020549?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTJ8fHBhcmFjaHV0ZSUyMGp1bXBpbmd8ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=600&q=60',
    duration: 30,
    activities: [
      'Visiting archaeological sites',
      'Walking tour',
      'Shopping at commercial centers',
      'Having lunch',
      'Enjoying beautiful scenery',
    ],
    program: [
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      'Ut enim ad minim veniam, quis nostrud exercitation ullamco.',
      'Laboris nisi ut aliquip ex ea commodo consequat.',
    ],
    isInSummer: true,
    isForFamilies: true,
    isInWinter: true,
  ),
];

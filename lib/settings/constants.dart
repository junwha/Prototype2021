const double pt = 96 / 72;

enum ArticleType { EVENT, COMPANION }

const String POST_RECRUITMENTS_COMPANION_API =
    'https://api.tripbuilder.co.kr/recruitments/companions/';
const String POST_RECRUITMENTS_EVENT_API =
    'https://api.tripbuilder.co.kr/recruitments/events/';

const kGoogleApiKey = "AIzaSyBhcuH45NaLJEqVuqGG7EmPqPPIJq9kumc";
const String placeHolder =
    "https://www.orcajourney.com/wp-content/uploads/2020/08/placeholder.png";

const String apiBaseUrl = 'https://api.tripbuilder.co.kr';

bool SAFE_HTTP_DEBUG = true;
// TODO: migrate this settings to secure storage
const String S3_BUCKET_NAME = "trip-builder";
const String S3_POOL_ID = "ap-northeast-2:454452c8-81de-43cb-9072-9d4b043fd38e";

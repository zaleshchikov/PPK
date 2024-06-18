import 'dart:ui';

JsonContentHeaders(String token) {
  return {'content-type': 'application/json', 'Authorization': "Bearer $token"};
}
const headers = {'content-type': 'application/json'};
final headersUrlencoded = {'content-type': 'application/x-www-form-urlencoded'};
final headersMedial = {'content-type': 'application/x-www-form-urlencoded'};
const publicMedia = '$mainUrl/public_goal/set_primary_image/';
const privateMedia = '$mainUrl/private_goal/set_primary_image/';
const mainUrl = 'http://vladcrabserver.tplinkdns.com';
const registerNewUserUrl = '$mainUrl/auth/register';
const loginUrl = '$mainUrl/auth/jwt/login';
const logoutUrl = '$mainUrl/auth/jwt/logout';
const forgotPassword = '$mainUrl/auth/forgot-password';
const resetPassword = '$mainUrl/auth/reset-password';
const createPrivateGoal = '$mainUrl/private_goal/';
const createPublicGoal = '$mainUrl/public_goal/';
const myGoals = '${createPublicGoal}my_goals/';
const createTask = '$mainUrl/daily_task/';
const privatTask = '$mainUrl/private_task/';
const dummyUser = '$mainUrl/auth/get_dummy_user';
const comments = '$mainUrl/comment/';
const user = '$mainUrl/users/';
const findUser = '$mainUrl/follow/find_user/';
const follow = '$mainUrl/follow/';


const tags = {
  "Семья" : 1,
  "Хобби": 2,
  "Спорт": 3,
  "Путешествия": 4,
  "Развитие": 5,
  "Здоровье": 6,
  "Карьера": 7,
  "Учеба": 8,
  "Активности": 9,
 "Финансы": 10,
  1: "Семья",
  2: "Хобби",
  3: "Спорт",
  4: "Путешествия",
  5: "Развитие",
  6: "Здоровье",
  7: "Карьера",
  8: "Учеба",
  9: "Активности",
  10: "Финансы"
};

const tagColor = {
  "Семья" : Color(0xffFBD784),
  "Спорт": Color(0xffECA66A),
  "Карьера": Color(0xffF26C43),
  "Путешествия": Color(0xffF3CAB1),
  "Хобби": Color(0xffC6A094),
  "Учеба": Color(0xff453643),
  "Развитие": Color(0xffE4BF9B),
  "Активности": Color(0xff5E4F48),
  "Здоровье": Color(0xffB09B73),
  "Финансы": Color(0xffDBC5A7),
};

monthNumberToName(int number) {
  switch (number) {
    case 1:
      return 'Января';
    case 2:
      return 'Февраля';
    case 3:
      return 'Марта';
    case 4:
      return 'Апреля';
    case 5:
      return 'Мая';
    case 6:
      return 'Июня';
    case 7:
      return 'Июля';
    case 8:
      return 'Августа';
    case 9:
      return 'Сентебря';
    case 10:
      return 'Октября';
    case 11:
      return 'Ноября';
    case 12:
      return 'Декабря';
  }
}
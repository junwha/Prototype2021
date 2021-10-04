## 개요

model/safe_http에 있는 safe_http.dart 와 base.dart, 그리고 safe_http 에 들어가는 .dart파일들에 대한 documentation입니다. 깃헙 리포지토리(2021.09.06 기준 safe-http 브랜치, merge되면 dev에서 찾아보실 수 있습니다) base.dart, safe_http.dart, output_dto_factory.dart, 그리고 data dto들의 소스코드가 있으며, 소스코드를 먼저 보시고 도큐멘테이션을 읽어보시는게 이해가 더 빠를겁니다🙂 혹여나 이해가 안되는 부분이 있으시다면 현규에게 물어봐주시면 감사하겠습니다.

### class SafeHttpInput

추후에 설명할 SafeMutationInput과 SafeQueryInput이 extends 하는 녀석입니다
constructor params는 다음과 같습니다

- required String url: 리퀘스트를 쏠 곳의 url입니다
- Map<String, String>? headers: 리퀘스트에 들어갈 헤더입니다.
- String? token: 헤더 Authorization에 들어갈 토큰입니다. headers 프로퍼티가 주어졌을 경우 override됩니다
또한 다음과 같은 메서드들을 포함합니다
- Map<String, String>? getHeaders(): 컨스트럭터에 token이 주어졌을 경우, Authorization이 inject된 헤더를 반환합니다. 그렇지 않을경우 원래의 헤더를 반환합니다
- Url getUrl(): url 스트링을 Uri 클래스로 변환하기 위한 메서드입니다

### class SafeHttpOutput

추후에 설명할 SafeMutationOutput과 SafeQueryOutput이 extends 하는 녀석입니다
constructor params는 다음과 같습니다

- required bool success: 리퀘스트가 성공적이었는지를 나타냅니다
- String? rawData: 리스폰스의 raw json string입니다. 타입 T가 **반드시** provide되어야 하며, rawData를 이용해 타입 T를 construct하여 T? data; 어트리뷰트로 설정합니다.
리퀘스트가 성공적이지 않았을 경우엔 null을 넣어 data가 null이 되도록 하고, error를 provide해줘야 합니다.
- SafeHttpError? error: 리퀘스트가 실패했을경우 에러 메세지를 담고 있는 클래스입니다

### abstract class SafeHttpDataInput

SafeMutationInput의 data나 SafeQueryInput의 params에 들어갈 타입들이 implement해야 하는 타입입니다.
예를들어 다음과 같이 사용됩니다

```dart
class LoginInput implements SafeHttpDataInput {
  final String username;
  final String password;

  LoginInput({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}

// Somewhere on the code
SafeMutationInput<LoginInput> dto = new SafeMutationInput<LoginInput>(username: 'alex', password: '1234');
```

toJson은 required method로, 위와 같이 jsonEncode를 위한 map을 반환하여야 합니다

### abstract class SafeHttpDataOutput

SafeHttpOutput 의 data에 들어갈 타입들이 implement해야 하는 타입입니다
dart는 constructor inheritance가 안되기 때문에, 사실 이 추상 클래스를 implement하는 것은 순전히 코드의 readability를 향상시키기 위함입니다.

```dart
class LoginOutput implements SafeHttpDataOutput {
  final String token;
  final int id;

  LoginOutput.fromJson({required Map<String, dynamic> json})
      : token = json['token'] as String,
        id = json['id'] as int;
}
```

fromJson이라는 named constructor가 위와 같이 반드시 포함되어 있어야 합니다

### class SafeHttpError

리퀘스트에 에러가 발생했을 시 반환할 수 있는 dto 클래스입니다
Constructor params는 다음과 같습니다

- required String message: 에러를 설명하는 메세지입니다

### class SafeMutationInput extends SafeHttpInput

SafeHttpInput을 extend합니다.
Post, put, patch와 같이 데이터가 리퀘스트에 실려가는 http메소드들을 위한 클래스입니다.
Params and methods:

- required T data: 리퀘스트에 실을 데이터입니다. 여기서 T는 실어보낼 데이터의 dto입니다
- String getJsonString: dto를 jsonString으로 변환한 값을 반환합니다
- Uri getUrlWithParams(): params가 주어졌을 경우, params에 있는 어트리뷰트들을 url스트링에 매핑하여 쿼리 스트링과 url params를 포함하는 Uri 를 반환합니다

### class SafeMutationOutput extends SafeHttpOutput

SafeHttpOutput을 extend 합니다.
Constructor 에서 SafeHttpOutput의 rawData가 data라는 이름으로 바뀝니다.

### class SafeQueryInput extends SafeHttpInput

SafeHttpInput을 extend합니다.
Get, option, delete와 같이 리퀘스트에 실려가는 데이터가 없는 http메소드들을 위한 클래스입니다.
Params and methods:

- T? Params: Query params의 목록을 담은 map을 반환할 dto가 들어갈 자리입니다
- Uri getUrlWithParams(): params가 주어졌을 경우, params에 있는 어트리뷰트들을 url스트링에 매핑하여 쿼리 스트링과 url params를 포함하는 Uri 를 반환합니다

### model/safe_http/output_dto_factory.dart **(IMPORTANT)**

```dart
// base.dart
class SafeHttpOutput<T extends SafeHttpDataOutput> {
  final bool success;
  final T? data;
  final SafeHttpError? error;

  SafeHttpOutput({required this.success, this.error, String? rawData})
      : data = rawData == null ? null : generateOutput<T>(rawData);
}

// output_dto_factory.dart
final factories = <Type, SafeHttpDataOutput Function(Map<String, dynamic>)>{
  AuthOutput: (Map<String, dynamic> json) => AuthOutput.fromJson(json: json),
  AuthVerificationOutput: (Map<String, dynamic> json) =>
      AuthVerificationOutput.fromJson(json: json),
  IdVerificationOutput: (Map<String, dynamic> json) =>
      IdVerificationOutput.fromJson(json: json),
  SignupOutput: (Map<String, dynamic> json) =>
      SignupOutput.fromJson(json: json),
  LoginOutput: (Map<String, dynamic> json) => LoginOutput.fromJson(json: json),
};

T generateOutput<T extends SafeHttpDataOutput>(String jsonString) {
  return factories[T]!(jsonDecode(jsonString)) as T;
}
```

어떤 통신 로직에 들어가는, SafeHttpDataOutput을 extend하는 output dto를 만들때에는 반드시 
factories에 output dto의 이름을 키로, 그리고 json 맵을 input으로 받고 output dto의 
fromJson constructor를 invoke시켜 반환하는 함수를 값으로 위와같이 꼭 삽입해 주셔야 합니다. 또한 
SafeHttpOutput을 사용할때는 꼭 output dto타입을 넣어주셔야 합니다
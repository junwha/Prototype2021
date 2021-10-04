### SimpleStorage
기기에 영구적으로 값을 저장하는 Storage이다.
값을 불러올 때 비동기 로직으로 불러오므로, 한 번 값을 불러온 뒤 캐싱하는 것이 좋다.

### SimpleStorageKeys
키 중복을 막기 위해 이곳에 모든 키를 정의한다.
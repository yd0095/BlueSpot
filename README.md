# Blue Spot  # ver.0

*Memo
구글 이메일 ID: capstone.bluespot@gmail.com / PWD: capstone
Firebase에서 저 계정으로 로그인 후 project capstone에 들어가면 우리 데이터베이스를 볼 수 있습니다.
안드로이드 에뮬레이터 GPS 설정법: https://stackoverflow.com/questions/47528006/how-to-set-the-location-manually-in-android-studio-emulator


1. Splash Page
- sub
- sub
2. Main Page
- sub
- sub
3. Map Page
- sub
- sub

---
이걸 MarkDown 언어라구 합니다.

md파일로 html에 그려지는 모습을 쉽게 그릴 수 있게 해주죠.

큰 변경사항은 README.md 파일에 차근차근 기록해주세요~
---





이상윤.
---20.11.18
1. 구글로그인의 문제점? ui 부분이라서 어떻게 해야할지 감이 안잡히네요. 하실 수 있는분 좀 부탁드려요.
이게 뭐냐면 처음에 어플켯을때 로그인이 되어있는지 안되어있는지 확인을 하는 기능이에요. splash에 넣으려고 했었는데 잘 안됏네요ㅠ
return FutureBuilder<FirebaseUser>(
      future: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        //유저가 만약에 가능하다면~
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          return 우리 메인 페이지.(uid: user.uid);
        }
        //유저가 로그인이 안되어 있따면.
        else {
          return 로그인 페이지.();
        }
      },
    );
이걸 main에 넣었어야 했는데 추가하지 못했음.

우선적으로 연동이 급선무인거 같아서 연동만 했음.
추후에 해야할 것.
2. 구글지도킨 다음 뒤로 돌아가야하는 버튼 추가해야함.
3. hot restart를 해야 위치를 받아오는거 확인됨 + 이제는 Hot restart를 해야 store에 마커가 저장이 되네요. -> 고쳐야함
4. 구글로그인 성공했는데 uid가 main에 안넘어 가는거 같네요. mainpage(uid: user.uid)로 하면 됐었는데 확인해야할듯
    -> 구글 로그인 성공했으니 거기에 있는 이름, 사진, 이메일 등을 우리 유저프로필에 넣어야함.
5. 맵 부분은 polyline API / waypoint  API 이용해서 서로 연결시키고 첨에 로그인을 했을때 내가 기존에 저장해둔 마커들을 파베에서 불러와서 띄어주는 것. 이것만하면 거의 완성인 거 같네요.
---


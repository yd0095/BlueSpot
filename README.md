# Blue Spot  # ver.0

☆Memo
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



20.11.23.
1. currentUser 연동 완료. 현재 드로워에서 우리 사진, 이름 계정 볼수있음.
    첫화면에서 로그인을 하면 바로 파베 userData에 생성하게 만들었음.
2. 우리 드로워에서 카메라 버튼 누르면 카메라/갤러리 나옴. (배경화면 바꾸게)
    -스토어와 연동안해서 구현X. 급선무 아니라서 나중으로 미뤘습니다.
3. 마커찍으면 파베에 "구" 로 나오는게 이제 "시"로 나옴.
4. 오류발견. -> 로그인이 안된상태에서 가끔 로그인 누르면 이유 없이 꺼지네요...해결법이?
5. mapPage까지 uid 연동 완료. markerId도 출력완료.





















이상윤.
---20.11.18
☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆이거 해결좀 엉엉☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
구글로그인의 문제점? ui 부분이라서 어떻게 해야할지 감이 안잡히네요. 하실 수 있는분 좀 부탁드려요.
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
☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆



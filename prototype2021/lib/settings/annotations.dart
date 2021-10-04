class _NeedsImplement {
  const _NeedsImplement();
}

/// 추상 메서드가 필수적으로 오버라이딩 되어야 함을 표시하는 어노테이션입니다
const _NeedsImplement needsImplement = const _NeedsImplement();

class _DefaultImplementation {
  const _DefaultImplementation();
}

/// 추상 메서드의 디폴트 값이 있고,
/// 추가로 필요한 기능이 있다면 [override] 할 수 있음을 표시하는 어노테이션입니다
const _DefaultImplementation defaultImplementation =
    const _DefaultImplementation();

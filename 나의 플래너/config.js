// 두 기기 동기화(Supabase) 설정
// publishable(anon) 키는 브라우저용 공개 키라 저장소에 올려도 됩니다. 데이터는 RLS 규칙으로 로그인한 본인만 읽고 쓸 수 있어요.
// 비워 두면 동기화 없이 이 기기에만 저장합니다.
window.PLANNER_CONFIG = {
  supabaseUrl: 'https://oihchufpdrbehlxwuotz.supabase.co',
  supabaseAnonKey: 'sb_publishable_iq-YLDumusrFHsYblF49Kg_RG7W6d2y',
};

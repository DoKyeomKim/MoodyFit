  function toggleDarkMode() {
        document.body.classList.toggle('dark-mode');
        const sidenav = document.querySelector('.sidenav');
        if (sidenav) {
            sidenav.classList.toggle('dark-mode');
        }
        // 다크 모드 상태를 로컬 스토리지에 저장
        const isDarkMode = document.body.classList.contains('dark-mode');
        localStorage.setItem('dark-mode', isDarkMode);
    }

    // 페이지 로드 시 다크 모드 상태 적용
    document.addEventListener('DOMContentLoaded', function() {
        const isDarkMode = localStorage.getItem('dark-mode') === 'true';
        if (isDarkMode) {
            document.body.classList.add('dark-mode');
        }
    });
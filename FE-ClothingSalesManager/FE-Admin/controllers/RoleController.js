function role($scope, $http) {
    const roleApi = "http://localhost:8080/admin/roles";

    $scope.updateIndex = -1;

    $scope.role = {
        id: "",
        name: ""
    }

    $scope.listRole = [];

    function clear() {
        $scope.role = {
            id: "",
            name: ""
        }
    }


    $http.get(roleApi).then(function (response) {
        $scope.listRole = response.data;
    }).catch(function (error) {
        // Xử lý lỗi
        console.error('Không thể lấy được dữ liệu: ', error);
        // Hiển thị thông báo cho người dùng
        alert('Không thể lấy được dữ liệu. Vui lòng thử lại sau.');
    });

    function post() {
        $http.post(roleApi, $scope.role)
            .then(function (response) {
                $scope.listRole.push($scope.role);
                clear();
            });
        console.log($scope.role);
    }

    $scope.btnUpdateOnClick = function (event, index) {
        event.preventDefault();

        const p = $scope.listRole[index];
        $scope.role.id = p.id;
        $scope.role.name = p.name;

        $scope.updateIndex = index;
        console.log(p.id);
    }

    function put() {
        $http.put(roleApi + "/" + $scope.listRole[$scope.updateIndex].id, $scope.role)
            .then(function (response) {
                $scope.listRole[$scope.updateIndex] = Object.assign({}, $scope.role);
                clear();
            });
        console.log($scope.role);
    }

    $scope.save = function (event) {
        event.preventDefault();

        if ($scope.updateIndex == -1) {
            post();
        } else {
            put();
        }
    }

    $scope.delete = function (event, index) {
        event.preventDefault();

        $http.delete(roleApi + "/" + $scope.listRole[index].id)
            .then(function (response) {
                $scope.listRole.splice(index, 1);
            });
    }
}
# 🚀 AWS Automated Infrastructure with Terraform

![AWS Architecture Diagram](./aws_architecture_diagram.png)

이 프로젝트는 **Terraform**을 사용하여 AWS 클라우드에 확장 가능하고 모니터링 가능한 인프라를 자동으로 구축하는 코드(IaC)입니다. 
개발자가 애플리케이션 개발에만 집중할 수 있도록 VPC, EC2(Docker 환경), RDS, ECR, 그리고 실시간 대시보드까지 한 번에 구성합니다.

---
## ✨ 주요 기능 및 특징 (Key Features)

### 1. 인프라 자동화 (Infrastructure as Code)
* **Terraform**을 사용하여 수동 조작 없이 AWS 인프라 전체(네트워크, 서버, DB, 보안)를 일관성 있게 생성하고 관리합니다.
* 코드 기반 관리를 통해 인프라의 변경 이력을 추적하고 빠르게 재구축할 수 있습니다.

### 2. 자동화된 서버 프로비저닝 (Automated Provisioning)
* **User Data** 스크립트를 활용해 EC2 인스턴스 생성 즉시 다음 환경을 자동 구성합니다:
  * **Docker & Docker-Compose:** 컨테이너 기반 애플리케이션 실행 환경.
  * **AWS CLI v2:** 클라우드 리소스 관리를 위한 도구.
  * **Amazon SSM Agent:** 보안을 강화한 원격 서버 관리.
  * **CloudWatch Agent:** 상세 메트릭 수집을 위한 에이전트.

### 3. 고가용성 네트워크 및 보안 설계
* **VPC & Multi-AZ:** 2개의 가용 영역(AZ)을 활용한 네트워크 설계로 가용성을 높였습니다.
* **IAM Role:** 최소 권한 원칙(Least Privilege)을 적용하여 EC2가 안전하게 ECR 및 CloudWatch와 통신합니다.
* **보안 그룹(Security Group):** 용도별(EC2, RDS) 보안 그룹 분리 및 포트 제어.

### 4. 통합 관제 대시보드 (Monitoring)
* **CloudWatch Dashboard:** 별도의 설정 없이도 EC2의 메모리/CPU 사용률과 RDS의 상태를 시각적으로 확인할 수 있는 통합 대시보드를 제공합니다.

---



## 📁 Terraform 모듈 구조 (Module Structure)



이 프로젝트는 Terraform의 모듈 기능을 적극 활용하여 인프라를 논리적인 단위로 분리하고 관리합니다. 이를 통해 코드의 재사용성을 높이고, 각 컴포넌트의 독립적인 관리가 가능하며, 대규모 인프라에서도 코드의 가독성과 유지보수성을 확보합니다.



주요 모듈은 다음과 같이 구성됩니다:



-   **`modules/vpc`**:

    -   AWS VPC(Virtual Private Cloud) 및 관련 네트워크 리소스(서브넷, 인터넷 게이트웨이, 라우팅 테이블)를 정의합니다.

    -   네트워크 격리 및 트래픽 라우팅을 담당하는 핵심 모듈입니다.



-   **`modules/security_groups`**:

    -   EC2 인스턴스 및 RDS 데이터베이스를 위한 보안 그룹을 정의합니다.

    -   인바운드/아웃바운드 트래픽 규칙을 중앙에서 관리하여 네트워크 보안을 강화합니다.



-   **`modules/ec2_instance`**:

    -   애플리케이션 서버로 사용될 EC2 인스턴스를 프로비저닝합니다.

    -   IAM 역할, 인스턴스 프로파일, SSH 키 페어, User Data 스크립트(Docker, SSM, CloudWatch Agent 설치) 등을 포함합니다.

    -   Elastic IP(EIP) 할당을 통해 고정 IP 주소를 제공합니다.



-   **`modules/rds`**:

    -   MySQL RDS(Relational Database Service) 인스턴스를 프로비저닝하고 관리합니다.

    -   DB 서브넷 그룹, IAM 역할(강화된 모니터링용) 등을 설정하여 데이터베이스의 가용성과 성능 모니터링을 지원합니다.



-   **`modules/ecr`**:

    -   Docker 이미지를 저장하고 관리하기 위한 ECR(Elastic Container Registry) 레포지토리를 생성합니다.

    -   이미지 스캔 설정 및 접근 정책을 정의합니다.



-   **`modules/cloudwatch_dashboard`**:

    -   EC2 및 RDS 인스턴스의 주요 메트릭을 시각화하는 CloudWatch Dashboard를 설정합니다.

    -   CPU 사용률, 메모리 사용률, 데이터베이스 연결 수 등을 한눈에 모니터링할 수 있도록 구성합니다.



각 모듈은 자체적인 `main.tf`, `variables.tf`, `outputs.tf` 파일을 가짐으로써 독립성을 유지하며, 루트(`main.tf`)에서는 이 모듈들을 조합하여 전체 인프라를 구성합니다. 루트의 `variables.tf`는 전체 프로젝트의 공통 변수를, `outputs.tf`는 외부에서 참조할 최종 출력 값을 정의합니다.



---



## 🛠 기술 스택 (Tech Stack)

| 구분 | 기술 | 상세 내용 |
| :--- | :--- | :--- |
| **Cloud** | **AWS** | VPC, EC2, RDS, ECR, CloudWatch, IAM |
| **IaC** | **Terraform** | 인프라 자원 자동 생성 및 상태 관리 |
| **Container** | **Docker** | 애플리케이션 컨테이너화 및 Docker-Compose 관리 |
| **OS** | **Ubuntu** | Ubuntu 24.04 LTS 최신 운영체제 활용 |
| **Database** | **MySQL** | RDS for MySQL 8.0 기반 관리형 DB |

---

## 📊 IaC(Terraform) 적용 전/후 비교 (Comparison)

인프라를 수동으로 구축하는 방식과 Terraform을 활용한 IaC(Infrastructure as Code) 방식의 주요 차이점을 비교합니다. Terraform을 통해 얻을 수 있는 정량적/정성적 이점은 다음과 같습니다.

| 구분           | 수동 구축 방식                               | IaC (Terraform) 방식                                           |
| :------------- | :------------------------------------------- | :------------------------------------------------------------- |
| **리소스 생성 시간** | 각 리소스별 수동 설정 및 대기 시간 발생        | 코드 변경 후 `terraform apply` 한 번으로 수분 내 배포 완료     |
| **설정 정확도**    | 휴먼 에러 발생 가능성 높음                     | 코드 기반으로 항상 동일한 설정 유지, 일관성 보장              |
| **일관성 및 재현성** | 환경별 설정 차이 발생 가능성 높음              | 개발, 스테이징, 운영 등 모든 환경에 동일한 인프라 배포 가능   |
| **버전 관리**      | 변경 이력 추적 어려움, 롤백 복잡                | Git 등을 통해 코드 변경 이력 관리, 손쉬운 롤백 및 협업         |
| **비용 효율성**    | 불필요한 리소스 잔존 및 관리 소홀로 비용 낭비 가능 | 필요한 리소스만 정확히 프로비저닝 및 관리, `terraform destroy`로 손쉬운 삭제 |
| **보안 및 규정 준수** | 수동 감사 및 정책 적용 어려움                  | 코드 리뷰를 통해 보안 정책 준수 여부 확인 용이, 자동화된 감사 가능 |
| **지식 공유**     | 특정 인력에게 지식 집중                     | 코드를 통한 인프라 구조 및 설정 파악 용이, 온보딩 시간 단축      |

---

## 🚀 실행 가이드 (Getting Started)

### 1. 사전 준비 (Prerequisites)
* **AWS CLI:** 로컬 환경에 설치 및 자격 증명(`aws configure`) 완료.
* **Terraform:** 로컬 환경에 설치 완료.
* **SSH Key:** 공개키 파일(`jjh-key.pub`)이 프로젝트 루트 폴더에 위치해야 합니다.

### 2. 설치 및 실행

```bash
# 프로젝트 복제 (또는 폴더 이동)
cd [프로젝트-폴더-이름]

# 1. 테라폼 초기화 (플러그인 설치)
terraform init

# 2. 실행 계획 확인 (변경 사항 검토)
- db_password는 변수로 입력받거나 terraform.tfvars 파일에 정의하세요.
terraform plan -var="db_password=your_secure_password"

# 3. 인프라 구축 실행
terraform apply -var="db_password=your_secure_password" -auto-approve
```

---



## 🏗 시스템 아키텍처



---

## 🛑 트러블슈팅 (Troubleshooting)

프로젝트를 진행하며 발생할 수 있는 일반적인 문제와 해결 방법을 공유합니다.

### 1. Terraform 권한 문제 (Permission Denied)
*   **Issue:** `terraform plan` 또는 `terraform apply` 실행 시 "Access Denied" 또는 "UnauthorizedOperation" 에러 발생.
*   **Cause:** AWS CLI를 통해 설정된 사용자 또는 역할에 Terraform이 생성하려는 리소스에 대한 권한이 없습니다.
*   **Solution:** AWS IAM 콘솔에서 현재 사용하고 있는 IAM User 또는 Role에 필요한 권한(예: `AdministratorAccess` 또는 필요한 서비스별 권한)을 부여합니다. 최소 권한의 원칙에 따라 필요한 권한만 부여하는 것이 좋습니다.

### 2. SSH 접속 문제 (SSH Connection Timed Out)
*   **Issue:** EC2 인스턴스에 SSH 접속 시 "Connection timed out" 에러 발생.
*   **Cause:**
    *   EC2 인스턴스의 보안 그룹 인바운드 규칙에 SSH(22번 포트) 허용이 안 되어 있습니다.
    *   로컬 환경의 IP 주소가 보안 그룹에 등록되어 있지 않습니다.
    *   `jjh-key.pem` 키 페어 파일의 권한이 너무 개방적입니다.
*   **Solution:**
    *   EC2 인스턴스에 연결된 보안 그룹의 인바운드 규칙에 22번 포트(SSH)가 허용되어 있는지 확인합니다.
    *   보안 그룹 규칙에 로컬 환경의 Public IP가 등록되어 있는지 확인합니다. (또는 테스트 목적으로 `0.0.0.0/0`으로 임시 설정)
    *   키 페어 파일(`jjh-key.pem`)의 권한을 `chmod 400 jjh-key.pem`으로 변경합니다.

---

## 📤 출력 값 (Outputs)

`terraform apply` 완료 후 다음 정보들을 확인할 수 있습니다:

*   `public_ip`: 배포된 EC2 인스턴스의 Public IP 주소.
*   `ssh_command`: EC2 인스턴스에 접속하기 위한 SSH 명령어 예시.
*   `instance_id`: EC2 인스턴스의 ID.
*   `ecr_repository_url`: ECR 레포지토리 URL.
*   `rds_endpoint`: RDS MySQL 데이터베이스의 엔드포인트.



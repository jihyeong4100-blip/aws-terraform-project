# 🚀 AWS Automated Infrastructure with Terraform

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

## 🛠 기술 스택 (Tech Stack)

| 구분 | 기술 | 상세 내용 |
| :--- | :--- | :--- |
| **Cloud** | **AWS** | VPC, EC2, RDS, ECR, CloudWatch, IAM |
| **IaC** | **Terraform** | 인프라 자원 자동 생성 및 상태 관리 |
| **Container** | **Docker** | 애플리케이션 컨테이너화 및 Docker-Compose 관리 |
| **OS** | **Ubuntu** | Ubuntu 24.04 LTS 최신 운영체제 활용 |
| **Database** | **MySQL** | RDS for MySQL 8.0 기반 관리형 DB |

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
# db_password는 변수로 입력받거나 terraform.tfvars 파일에 정의하세요.
terraform plan -var="db_password=your_secure_password"

# 3. 인프라 구축 실행
terraform apply -var="db_password=your_secure_password" -auto-approve

---



## 🏗 시스템 아키텍처



```mermaid
graph TD
    subgraph AWS_Cloud ["AWS Cloud (ap-northeast-2)"]
        subgraph VPC ["VPC (10.0.0.0/16)"]
            IGW["Internet Gateway"]
            
            subgraph Subnet_A ["Public Subnet A (ap-northeast-2a)"]
                EC2["EC2 Instance (App Server)"]
                RDS_A["RDS Instance (Primary)"]
            end
            
            subgraph Subnet_C ["Public Subnet C (ap-northeast-2c)"]
                RDS_C["RDS Subnet"]
            end
            
            RT["Public Route Table"]
        end

        ECR["Amazon ECR (jjh-backend)"]
        CW["CloudWatch Dashboard"]
        SSM["AWS Systems Manager"]
    end

    User -->|SSH/HTTP| IGW
    IGW --> EC2
    EC2 --> RDS_A
    EC2 --> ECR
    EC2 -.->|Metrics| CW
    SSM -.->|Manage| EC2


# AWARE Infrastructure Configuration
# This file defines the application infrastructure parameters for self-adaptive optimization.
# Patchable variables are defined in the locals block below.

locals {
  # ===========================================
  # Application Auto Scaling Group Configuration
  # ===========================================
  
  # Instance type for application servers
  # Options: t3.nano, t3.micro, t3.small, t3.medium, t3.large, t3.xlarge, t3.2xlarge
  #          c5.large, c5.xlarge, c5.2xlarge, c5.4xlarge, c5.9xlarge (compute-optimized)
  app_instance_type = "c5.2xlarge"

  # Auto Scaling Group capacity settings
  app_desired_capacity = 3  # Target number of running instances
  app_min_size         = 3  # Minimum instances (HA requirement: >= 3)
  app_max_size         = 6  # Maximum instances for auto-scaling headroom

  # Enable detailed CloudWatch monitoring (1-minute intervals)
  enable_detailed_monitoring = true

  # ===========================================
  # RDS Database Configuration
  # ===========================================
  
  # RDS instance class
  # Options: db.t3.micro, db.t3.small, db.t3.medium, db.r5.large, db.r5.xlarge
  rds_instance_class = "db.r5.large"

  # Allocated storage in GB
  rds_allocated_storage = 100

  # Multi-AZ deployment for high availability
  rds_multi_az = true

  # Read replica for read scaling
  enable_read_replica = false

  # ===========================================
  # ElastiCache Redis Configuration
  # ===========================================
  
  # Cache node type
  # Options: cache.t3.micro, cache.t3.small, cache.t3.medium, cache.r5.large
  cache_node_type = "cache.t3.medium"

  # Number of cache nodes (2+ for cluster mode)
  cache_num_nodes = 2

  # ===========================================
  # ALB (Application Load Balancer) Configuration
  # ===========================================
  
  # Idle timeout in seconds
  alb_idle_timeout = 60

  # ===========================================
  # CloudWatch Alarm Thresholds
  # ===========================================
  
  # CPU utilization threshold for scaling alerts
  cloudwatch_cpu_threshold = 70

  # Memory utilization threshold for scaling alerts
  cloudwatch_memory_threshold = 80

  # RDS CPU utilization threshold
  cloudwatch_rds_cpu_threshold = 70

  # ALB 5xx error rate threshold
  cloudwatch_alb_5xx_threshold = 5

  # ===========================================
  # Network & High Availability Configuration
  # ===========================================
  
  # NAT Gateway per availability zone (cost vs availability tradeoff)
  nat_gateway_per_az = true

  # Cross-region failover for disaster recovery
  enable_cross_region_failover = false
}

# ===========================================
# AWARE Metadata
# ===========================================
# Last modified: 2026-03-27 by AWARE Act agent
# Change reason: Critical CPU saturation (91%) + single-replica degraded mode
# Target function: x6 (Compute Capacity)
# Selected option: Full HA with Strong Compute (Option C)
# Predicted scores: y=0.2225, x6=0.95, x7=0.95
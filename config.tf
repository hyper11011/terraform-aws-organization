# =============================================================================
# AWARE Self-Adaptive Infrastructure Configuration
# =============================================================================
# This file contains the patchable locals for application infrastructure.
# The AWARE framework modifies these values based on multi-objective optimization.
#
# Patchable Variables:
#   - app_instance_type: EC2 instance type (ARM Graviton recommended for efficiency)
#   - app_desired_capacity: Target number of instances
#   - app_min_size: Minimum instances for autoscaling
#   - app_max_size: Maximum instances for autoscaling
#   - enable_detailed_monitoring: CloudWatch detailed monitoring (1-min vs 5-min)
#   - rds_instance_class: RDS database instance type
#   - rds_allocated_storage: RDS storage in GB
#   - rds_multi_az: Enable Multi-AZ for RDS
#   - enable_read_replica: Enable read replica for RDS
#   - cache_node_type: ElastiCache node type
#   - cache_num_nodes: Number of cache nodes
#   - alb_idle_timeout: ALB idle timeout in seconds
#   - cloudwatch_cpu_threshold: CPU alarm threshold (%)
#   - cloudwatch_memory_threshold: Memory alarm threshold (%)
#   - cloudwatch_rds_cpu_threshold: RDS CPU alarm threshold (%)
#   - cloudwatch_alb_5xx_threshold: ALB 5xx error threshold
#   - nat_gateway_per_az: NAT gateway per availability zone
#   - enable_cross_region_failover: Enable cross-region disaster recovery
# =============================================================================

locals {
  # --------------------------------------------------------------------------
  # Application Compute Configuration
  # --------------------------------------------------------------------------
  # PATCHED: Changed from t3.large (x86 Intel) to t4g.large (ARM Graviton)
  # Rationale: ARM Graviton processors are 20-40% more energy-efficient,
  #            reducing carbon footprint while maintaining equivalent performance.
  #            This addresses the primary x1 (Carbon Efficiency) optimization goal.
  app_instance_type = "t4g.large"
  
  # Application autoscaling configuration
  app_desired_capacity = 2
  app_min_size         = 1
  app_max_size         = 3
  
  # Enable CloudWatch detailed monitoring (1-minute intervals)
  enable_detailed_monitoring = true

  # --------------------------------------------------------------------------
  # RDS Database Configuration
  # --------------------------------------------------------------------------
  rds_instance_class    = "db.t3.medium"
  rds_allocated_storage = 100
  rds_multi_az          = false
  enable_read_replica   = false

  # --------------------------------------------------------------------------
  # ElastiCache Configuration
  # --------------------------------------------------------------------------
  cache_node_type = "cache.t3.micro"
  cache_num_nodes = 1

  # --------------------------------------------------------------------------
  # Load Balancer Configuration
  # --------------------------------------------------------------------------
  alb_idle_timeout = 60

  # --------------------------------------------------------------------------
  # CloudWatch Alarm Thresholds
  # --------------------------------------------------------------------------
  cloudwatch_cpu_threshold      = 80
  cloudwatch_memory_threshold   = 80
  cloudwatch_rds_cpu_threshold  = 80
  cloudwatch_alb_5xx_threshold  = 5

  # --------------------------------------------------------------------------
  # Network Configuration
  # --------------------------------------------------------------------------
  # NAT gateway per availability zone (set to 1 for cost efficiency)
  nat_gateway_per_az = 1
  
  # Cross-region failover for disaster recovery
  enable_cross_region_failover = false

  # --------------------------------------------------------------------------
  # AWARE Metadata (for tracking)
  # --------------------------------------------------------------------------
  aware_optimization_target   = "x1"           # Carbon Efficiency
  aware_optimization_reason   = "Reduce carbon footprint by 40% through ARM Graviton migration"
  aware_previous_instance_type = "t3.large"    # x86 Intel baseline
  aware_patch_timestamp       = "2026-03-27"
  aware_predicted_score       = 0.92          # Predicted x1 score
}
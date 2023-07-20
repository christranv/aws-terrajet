[
  {
    "name": "${app_name}",
    "image": "${image_url}",
    "essential": true,
    "cpu": ${task_cpu},
    "memory": ${task_memory},
    "memoryReservation": null,
    "links": [],
    "portMappings": [
      {
        "containerPort": ${container_port},
        "hostPort": ${host_port},
        "protocol": "tcp"
      }
    ],
    "command": null,
    "environment": ${variables},
    "healthCheck": {
        "retries": 5,
        "command": ["CMD-SHELL","curl -f http://localhost${health_check_path} || exit 1"],
        "timeout": 10,
        "interval": 5,
        "startPeriod": null
    },
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${app_name}"
      }
    }
  }
]

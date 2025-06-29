"""
Shared pytest fixtures and configuration for all tests.
"""
import os
import tempfile
from pathlib import Path
from typing import Generator, Dict, Any
import pytest


@pytest.fixture
def temp_dir() -> Generator[Path, None, None]:
    """
    Create a temporary directory for test files.
    
    Yields:
        Path: Path to the temporary directory
    """
    with tempfile.TemporaryDirectory() as tmp_dir:
        yield Path(tmp_dir)


@pytest.fixture
def mock_config() -> Dict[str, Any]:
    """
    Provide a mock configuration dictionary for testing.
    
    Returns:
        Dict[str, Any]: Mock configuration data
    """
    return {
        "debug": False,
        "version": "0.1.0",
        "environment": "test",
        "database": {
            "host": "localhost",
            "port": 5432,
            "name": "test_db",
            "user": "test_user",
            "password": "test_password"
        },
        "api": {
            "base_url": "http://localhost:8000",
            "timeout": 30,
            "retries": 3
        }
    }


@pytest.fixture
def sample_yaml_content() -> str:
    """
    Provide sample YAML content for testing Ansible playbooks.
    
    Returns:
        str: Sample YAML content
    """
    return """---
- name: Test Playbook
  hosts: localhost
  tasks:
    - name: Test task
      debug:
        msg: "This is a test task"
"""


@pytest.fixture
def sample_json_data() -> Dict[str, Any]:
    """
    Provide sample JSON data for testing.
    
    Returns:
        Dict[str, Any]: Sample JSON data
    """
    return {
        "items": [
            {"id": 1, "name": "Item 1", "value": 100},
            {"id": 2, "name": "Item 2", "value": 200},
            {"id": 3, "name": "Item 3", "value": 300}
        ],
        "metadata": {
            "total": 3,
            "page": 1,
            "per_page": 10
        }
    }


@pytest.fixture
def mock_env_vars(monkeypatch) -> Dict[str, str]:
    """
    Set up mock environment variables for testing.
    
    Args:
        monkeypatch: pytest monkeypatch fixture
        
    Returns:
        Dict[str, str]: Dictionary of environment variables that were set
    """
    env_vars = {
        "TEST_VAR": "test_value",
        "DEBUG": "true",
        "API_KEY": "mock_api_key_12345",
        "DATABASE_URL": "postgresql://test:test@localhost/test"
    }
    
    for key, value in env_vars.items():
        monkeypatch.setenv(key, value)
    
    return env_vars


@pytest.fixture
def clean_environment(monkeypatch):
    """
    Remove specific environment variables to ensure clean test environment.
    
    Args:
        monkeypatch: pytest monkeypatch fixture
    """
    env_vars_to_remove = ["DEBUG", "API_KEY", "DATABASE_URL", "CONFIG_PATH"]
    
    for var in env_vars_to_remove:
        monkeypatch.delenv(var, raising=False)


@pytest.fixture(autouse=True)
def change_test_dir(request, monkeypatch):
    """
    Change to test directory for the duration of the test.
    
    Args:
        request: pytest request fixture
        monkeypatch: pytest monkeypatch fixture
    """
    monkeypatch.chdir(request.fspath.dirname)


@pytest.fixture
def mock_file_system(temp_dir: Path) -> Dict[str, Path]:
    """
    Create a mock file system structure for testing.
    
    Args:
        temp_dir: Temporary directory path
        
    Returns:
        Dict[str, Path]: Dictionary mapping file types to their paths
    """
    # Create directory structure
    dirs = {
        "config": temp_dir / "config",
        "data": temp_dir / "data",
        "logs": temp_dir / "logs",
        "scripts": temp_dir / "scripts"
    }
    
    for dir_path in dirs.values():
        dir_path.mkdir(parents=True, exist_ok=True)
    
    # Create some sample files
    files = {
        "config_file": dirs["config"] / "app.conf",
        "data_file": dirs["data"] / "sample.json",
        "log_file": dirs["logs"] / "app.log",
        "script_file": dirs["scripts"] / "test_script.py"
    }
    
    # Write content to files
    files["config_file"].write_text("# Configuration file\\nkey=value")
    files["data_file"].write_text('{"test": "data"}')
    files["log_file"].write_text("2024-01-01 00:00:00 INFO Test log entry")
    files["script_file"].write_text("#!/usr/bin/env python\\nprint('test')")
    
    return {**dirs, **files}


# Pytest hooks for better test organization and reporting
def pytest_configure(config):
    """
    Configure pytest with custom settings.
    
    Args:
        config: pytest config object
    """
    config.addinivalue_line(
        "markers", "network: mark test as requiring network access"
    )
    config.addinivalue_line(
        "markers", "database: mark test as requiring database access"
    )


def pytest_collection_modifyitems(config, items):
    """
    Modify test collection to add markers based on test location.
    
    Args:
        config: pytest config object
        items: list of test items
    """
    for item in items:
        # Add unit marker to tests in unit directory
        if "unit" in str(item.fspath):
            item.add_marker(pytest.mark.unit)
        # Add integration marker to tests in integration directory
        elif "integration" in str(item.fspath):
            item.add_marker(pytest.mark.integration)
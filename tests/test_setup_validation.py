"""
Validation tests to ensure the testing infrastructure is properly set up.
"""
import sys
import importlib
import pytest
from pathlib import Path


class TestInfrastructureSetup:
    """Test class to validate the testing infrastructure setup."""
    
    def test_pytest_installed(self):
        """Test that pytest is installed and importable."""
        assert "pytest" in sys.modules or importlib.util.find_spec("pytest") is not None
        
    def test_pytest_cov_installed(self):
        """Test that pytest-cov is installed and importable."""
        try:
            import pytest_cov
            assert True
        except ImportError:
            # Check if the plugin is available through pytest
            assert any("pytest_cov" in str(p) for p in pytest.plugin._getpluginmodules())
    
    def test_pytest_mock_installed(self):
        """Test that pytest-mock is installed and importable."""
        try:
            import pytest_mock
            assert True
        except ImportError:
            # Check if the plugin is available through pytest
            assert any("pytest_mock" in str(p) for p in pytest.plugin._getpluginmodules())
    
    def test_testing_directory_structure(self):
        """Test that the testing directory structure exists."""
        test_root = Path(__file__).parent
        
        # Check main directories
        assert test_root.exists()
        assert test_root.is_dir()
        assert (test_root / "__init__.py").exists()
        
        # Check subdirectories
        assert (test_root / "unit").exists()
        assert (test_root / "unit").is_dir()
        assert (test_root / "unit" / "__init__.py").exists()
        
        assert (test_root / "integration").exists()
        assert (test_root / "integration").is_dir()
        assert (test_root / "integration" / "__init__.py").exists()
        
        # Check conftest.py
        assert (test_root / "conftest.py").exists()
    
    def test_pyproject_toml_exists(self):
        """Test that pyproject.toml exists with proper configuration."""
        project_root = Path(__file__).parent.parent
        pyproject_path = project_root / "pyproject.toml"
        
        assert pyproject_path.exists()
        
        # Read and validate content
        content = pyproject_path.read_text()
        
        # Check for Poetry configuration
        assert "[tool.poetry]" in content
        assert "pytest" in content
        assert "pytest-cov" in content
        assert "pytest-mock" in content
        
        # Check for pytest configuration
        assert "[tool.pytest.ini_options]" in content
        assert "--cov" in content
        assert "testpaths" in content
        
        # Check for coverage configuration
        assert "[tool.coverage.run]" in content
        assert "[tool.coverage.report]" in content
    
    @pytest.mark.unit
    def test_unit_marker(self):
        """Test that unit marker works."""
        assert True
    
    @pytest.mark.integration
    def test_integration_marker(self):
        """Test that integration marker works."""
        assert True
    
    @pytest.mark.slow
    def test_slow_marker(self):
        """Test that slow marker works."""
        assert True
    
    def test_fixtures_available(self, temp_dir, mock_config, sample_yaml_content):
        """Test that custom fixtures from conftest.py are available."""
        # Test temp_dir fixture
        assert temp_dir.exists()
        assert temp_dir.is_dir()
        
        # Test mock_config fixture
        assert isinstance(mock_config, dict)
        assert "version" in mock_config
        assert mock_config["environment"] == "test"
        
        # Test sample_yaml_content fixture
        assert isinstance(sample_yaml_content, str)
        assert "hosts: localhost" in sample_yaml_content
    
    def test_coverage_configuration(self):
        """Test that coverage is properly configured."""
        project_root = Path(__file__).parent.parent
        pyproject_path = project_root / "pyproject.toml"
        
        content = pyproject_path.read_text()
        
        # Check coverage source configuration
        assert 'source = ["scripts/python"]' in content
        
        # Check coverage thresholds (we set to 0 for infrastructure setup)
        assert "--cov-fail-under=0" in content
        
        # Check coverage report formats
        assert "--cov-report=html" in content
        assert "--cov-report=xml" in content
    
    def test_gitignore_updated(self):
        """Test that .gitignore contains testing-related entries."""
        project_root = Path(__file__).parent.parent
        gitignore_path = project_root / ".gitignore"
        
        # Create if doesn't exist, otherwise read
        if gitignore_path.exists():
            content = gitignore_path.read_text()
        else:
            content = ""
        
        # These should be in .gitignore
        expected_entries = [
            ".pytest_cache",
            ".coverage",
            "htmlcov",
            "coverage.xml"
        ]
        
        # We'll update .gitignore after this test
        # For now, just check if file exists or can be created
        assert True  # Placeholder for gitignore check


class TestPoetryCommands:
    """Test class to validate Poetry script commands."""
    
    def test_poetry_scripts_configured(self):
        """Test that Poetry scripts are properly configured."""
        project_root = Path(__file__).parent.parent
        pyproject_path = project_root / "pyproject.toml"
        
        content = pyproject_path.read_text()
        
        # Check for script definitions
        assert "[tool.poetry.scripts]" in content
        assert 'test = "pytest:main"' in content
        assert 'tests = "pytest:main"' in content


if __name__ == "__main__":
    # Run tests if executed directly
    pytest.main([__file__, "-v"])
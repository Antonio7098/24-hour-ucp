#!/usr/bin/env python3
"""
Run script for 24h-testers UCP testing.

Uses the 24h-testers package with custom agent-resources override
for UCP-specific testing.
"""

import argparse
import asyncio
import sys
from pathlib import Path

# Import from the 24h-testers package
from processor import ChecklistProcessor, ProcessorConfig
from processor.config import ProcessingMode, AgentRuntime


def parse_args():
    """Parse command-line arguments."""
    parser = argparse.ArgumentParser(
        description="Run 24h-testers UCP testing with custom agent-resources"
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Preview processing without executing agents",
    )
    parser.add_argument(
        "--batch-size", "-b",
        type=int,
        default=5,
        help="Number of items to process in parallel (default: 5)",
    )
    parser.add_argument(
        "--max-iterations",
        type=int,
        default=50,
        help="Maximum iterations (default: 50)",
    )
    parser.add_argument(
        "--runtime", "-r",
        choices=["opencode", "claude-code"],
        default="opencode",
        help="Agent runtime to use (default: opencode)",
    )
    parser.add_argument(
        "--model",
        type=str,
        default=None,
        help="Model to use (default: runtime default)",
    )
    parser.add_argument(
        "--timeout",
        type=int,
        default=600000,
        help="Agent timeout in milliseconds (default: 600000 = 10 min)",
    )
    parser.add_argument(
        "--verbose", "-v",
        action="store_true",
        help="Enable verbose logging",
    )
    return parser.parse_args()


def main():
    """Main entry point for UCP testing."""
    args = parse_args()

    # Get the directory where this script is located
    repo_root = Path(__file__).parent.resolve()

    # Configure processor with UCP-specific agent-resources
    config = ProcessorConfig(
        repo_root=repo_root,
        # Use the modified agent-resources in this repo
        agent_resources_dir=repo_root / "agent-resources",
        # Processing settings
        batch_size=args.batch_size,
        max_iterations=args.max_iterations,
        mode=ProcessingMode.FINITE,
        dry_run=args.dry_run,
        # Agent settings
        runtime=AgentRuntime(args.runtime),
        model=args.model,
        timeout_ms=args.timeout,
        verbose=args.verbose,
    )

    print(f"UCP Testing Configuration:")
    print(f"  Repo root: {config.repo_root}")
    print(f"  Agent resources: {config.agent_resources_dir}")
    print(f"  Checklist: {config.checklist_path}")
    print(f"  Runtime: {config.runtime.value}")
    print(f"  Model: {config.get_model()}")
    print(f"  Batch size: {config.batch_size}")
    print(f"  Max iterations: {config.max_iterations}")
    print(f"  Dry run: {config.dry_run}")
    print()

    # Create and run processor
    processor = ChecklistProcessor(config)

    # Handle Ctrl+C gracefully
    import signal
    def handle_signal(signum, frame):
        print("\nReceived interrupt, cancelling...")
        processor.cancel_all()
        sys.exit(1)

    signal.signal(signal.SIGINT, handle_signal)
    signal.signal(signal.SIGTERM, handle_signal)

    # Run the processor
    result = asyncio.run(processor.process())

    # Report results
    print()
    print(f"Processing Complete:")
    print(f"  Processed: {result.processed}")
    print(f"  Completed: {result.completed}")
    print(f"  Failed: {result.failed}")
    if result.dry_run:
        print("  (Dry run - no agents were executed)")

    return 1 if result.failed > 0 else 0


if __name__ == "__main__":
    sys.exit(main())
